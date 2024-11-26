### **Step 1: Install QEMU and Required Packages**
First, we just need to install dependency for all qemu installation, after some installation, there will be 3 choices;
1. qemu-base
2. qemu-desktop
3. qemu-full
<br>the different? well, if you are an advanced user that need configure all of you wanted, you can use qemu-base that are so minim on installation, you are your own captain, the qemu-desktop is the way for general user, i mean, it contain decent-good lib that support general emulations, the qemu-desktop is full configuration well to go, but heavy.

```bash
sudo pacman -S qemu virt-manager virt-viewer libvirt dnsmasq vde2 bridge-utils openbsd-netcat edk2-ovmf
```

---

### **Step 2: Enable Virtualization Support**
You need a CPU supports for virtualization:
1. Enable **VT-x** (Intel) or **AMD-V** (AMD) in your BIOS/UEFI settings.
2. Verify if your system supports virtualization:
   ```bash
   egrep -o '(vmx|svm)' /proc/cpuinfo
   ```
   If no output appears, you might need to enable it in the BIOS/UEFI. it is easy... just go way to google what it is, every laptop and PC had different keystroke to go to BIOS.

---

### **Step 3: Configure and Start Libvirt**
1. **Start and Enable the Libvirt Service**:
   ```bash
   sudo systemctl enable --now libvirtd
   ```

2. **Add Your User to the `libvirt` Group**:
   Add yourself to the `libvirt` group to avoid using `sudo` every time:
   ```bash
   sudo usermod -aG libvirt $(whoami)
   ```
   Log out and log back in to apply the group change.
3. **Check the Status of Libvirt**:
   ```bash
   systemctl status libvirtd
   ```
---
*VERY IMPORTANT NOTE :
if you encounter an error like this :
```bash
Nov 21 19:35:23 archlinux libvirtd[10559]: Cannot find 'dmidecode' in path: No such file or directory
Nov 21 19:35:23 archlinux libvirtd[10559]: Unable to open /dev/kvm: No such file or directory
Nov 21 19:35:23 archlinux libvirtd[10559]: Cannot find 'dmidecode' in path: No such file or directory
```
---
you need to mount kvm by :
```bash
lsmod | grep kvm
sudo modprobe kvm
sudo modprobe kvm_(your cpu) #intel/amd
```
then you need to confirm it is load by :

```bash
ls -l /dev/kvm
```
also, install some package/library that are not in there, for exammple in this case is dmicode just install the package that lack.
after that, you need to restart libvirt by :
```bash
sudo systemctl restart libvirtd
and >
systemctl status libvirtd #For confirming that it perfectly loaded.
```
---
### **Step 4: Set Up Networking**
Libvirt sets up a default network for your virtual machines. To ensure it works just type:
1. Start the default network:
   ```bash
   sudo virsh net-start default
   ```
2. Enable autostart for the network:
   ```bash
   sudo virsh net-autostart default
   ```

Verify that the network is active:
```bash
sudo virsh net-list
```

---

### **Step 5: Create and Run Virtual Machines**
1. **Launch Virt-Manager**:
   Start the GUI tool for managing virtual machines:
   ```bash
   virt-manager
   ```

2. **Create a New Virtual Machine**:
   - Open Virt-Manager and click on **"Create a New Virtual Machine"**.
   - Choose how you want to install the OS:
     - From an ISO image (e.g., Ubuntu, Fedora).
     - PXE boot or a disk image.
   - Allocate resources:
     - Memory (RAM): Allocate at least 2 GB (2048 MB) for most modern OSes.
     - CPUs: Assign 2 or more cores if available.
   - Disk Storage: Create or assign a virtual disk (e.g., 20 GB for basic setups).

3. **Choose Firmware**:
   - For modern OSes, select **UEFI firmware** under **Advanced Options**.
   - Ensure **OVMF** (provided by `edk2-ovmf`) is selected.

4. **Finish Configuration**:
   - Add optional devices (e.g., additional network interfaces or USB devices).
   - Complete the setup and start the virtual machine.

---

### **Step 6: Optional Performance Enhancements**
For better performance:
1. Enable KVM acceleration if supported:
   ```bash
   qemu-system-x86_64 -enable-kvm -cpu host -smp 2 -m 2048 -hda disk.img
   ```

2. Increase allocated CPU cores, RAM, or disk size based on your hardware capacity.

---

### **Step 7: Run and Manage Virtual Machines**
- Start and manage VMs via **Virt-Manager** for ease of use.
- Alternatively, use `virsh` commands to manage them in the terminal:
  - List all VMs:
    ```bash
    virsh list --all
    ```
  - Start a VM:
    ```bash
    virsh start <vm-name>
    ```
  - Shut down a VM:
    ```bash
    virsh shutdown <vm-name>
    ```
