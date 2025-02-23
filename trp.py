#!/usr/bin/env python3

import re
import sys
import subprocess
import os

ERROR_FILE = "/tmp/.trp_errors" if os.name != "nt" else os.path.expandvars(r"%TEMP%\trp_errors.txt")

def reset_error_file():
    """Clears previous error data."""
    open(ERROR_FILE, "w").close()

def get_last_command():
    """Retrieve the last executed command from Zsh (Mac/Linux) or PowerShell (Windows)."""
    try:
        if os.name == "nt":
            result = subprocess.run(["powershell", "-Command", 
                                    "(Get-History | Select-Object -Last 2 | Select-Object -First 1).CommandLine"], 
                                    capture_output=True, text=True)
        else:
            result = subprocess.run("fc -ln -2 | tail -1", shell=True, capture_output=True, text=True, executable="/bin/zsh")
        
        last_command = result.stdout.strip()
        if last_command:
            print(f"DEBUG: Retrieved last command -> {repr(last_command)}")
            return last_command

    except Exception as e:
        print(f"ERROR: Exception while retrieving last command: {e}")

    print("ERROR: No last command found.")
    return None

def extract_error_paths():
    """Extracts file paths and line numbers from the last command's stderr output and saves them."""
    try:
        reset_error_file()

        last_command = get_last_command()
        if not last_command:
            sys.exit(1)

        print(f"DEBUG: Final cleaned last command -> {last_command}")

        proc = subprocess.run(last_command, shell=True, executable="/bin/zsh" if os.name != "nt" else "powershell", capture_output=True, text=True)
        error_output = proc.stderr.strip()

        print(f"DEBUG: Captured stderr -> {repr(error_output)}")

        if not error_output:
            print("ERROR: No stderr output captured.")
            sys.exit(0)

        pattern = r'File "([^"]+)", line (\d+)'
        matches = re.findall(pattern, error_output)

        if matches:
            with open(ERROR_FILE, "w") as f:
                for file_path, line_number in matches:
                    error_entry = f"{file_path} +{line_number}"
                    print(f"DEBUG: Extracted {error_entry}")
                    f.write(error_entry + "\n")

        print(f"DEBUG: Errors saved to {ERROR_FILE}")

    except Exception as e:
        print(f"ERROR: Exception occurred: {e}")
        sys.exit(1)

if __name__ == "__main__":
    extract_error_paths()

