### **🔥 TRP - Instant Error Navigation for `nvim`**  

🚀 **Extracts file paths & line numbers from Python errors and enables `nvim <TAB>` autocompletion.**  
Works on **Mac, Linux (Zsh), and Windows (PowerShell).**

---

## **📂 File Structure**
```
trp/
│── install.sh      # Installer for Mac/Linux (Zsh)
│── install.ps1     # Installer for Windows (PowerShell)
│── trp.py          # Core script that extracts errors
│── README.md       # Usage instructions
```

---

## **📥 Installation**
### **Mac & Linux (Zsh)**
```sh
git clone https://github.com/lamaxko/trp.git
cd trp
chmod +x install.sh
./install.sh
source ~/.zshrc
```

### **Windows (PowerShell)**
```powershell
Set-ExecutionPolicy Unrestricted -Scope CurrentUser -Force
iwr -useb https://raw.githubusercontent.com/lamaxko/trp/main/install.ps1 | iex
```
🔄 **Restart PowerShell after installation.**

---

## **🚀 Usage**
1️⃣ **Run a Python script that throws an error**:
   ```sh
   python3 script.py  # Or python script.py on Windows
   ```

2️⃣ **Use `nvim <TAB>` to autocomplete errors**:
   ```sh
   nvim <TAB>
   ```
   ✅ Autocompletes paths like:
   ```
   ~/some/path/script.py +2
   ~/some/path/another.py +10
   ```

3️⃣ **Open an error directly in `nvim`**:
   ```sh
   nvim ~/some/path/script.py +2
   ```
   ✅ Opens `script.py` at **line 2**.

---

## **🛠️ Uninstall**
### **Mac & Linux**
```sh
rm -f /usr/local/bin/trp
sed -i '' '/trp.py/d' ~/.zshrc
rm -f /tmp/.trp_errors
```

### **Windows**
```powershell
Remove-Item -Path C:\trp -Recurse -Force
(Get-Content $PROFILE) -notmatch "trp.py" | Set-Content $PROFILE
```

---

### **🚀 Now You Can Instantly Open Errors in `nvim`!**  
Try it out & speed up debugging! 🔥
