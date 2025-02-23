### **🔥 TRP - Instant Error Navigation for `nvim`**  

🚀 **Extracts file paths & line numbers from Python errors and enables `nvim <TAB>` autocompletion.**  
Works on **Mac, Linux (Zsh), and Windows (PowerShell).**

---

## **📥 Installation**
### **Mac & Linux (Zsh)**
```sh
git clone https://github.com/lamaxko/trp.git
```
```sh
cd trp
```
```sh
chmod +x install.sh
```
```sh
./install.sh
```
```sh
source ~/.zshrc
```

### **Windows (PowerShell)**
```powershell
Set-ExecutionPolicy Unrestricted -Scope CurrentUser -Force
```
```powershell
iwr -useb https://raw.githubusercontent.com/lamaxko/trp/main/install.ps1 | iex
```
🔄 **Restart PowerShell after installation.**

---

## **🚀 Usage**
1️⃣ **Run your Python script that throws an error**:
   ```sh
   py script.py
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

### **🚀 Now You Can Instantly Navigate to Errors in `nvim`!**  
Try it out & speed up your debugging! 🔥
