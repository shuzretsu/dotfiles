### **Step 1: Install QEMU and Required Packages**
Run the following command to install QEMU and basic dependencies:
```bash
sudo pacman -S qemu virt-manager virt-viewer libvirt dnsmasq vde2 bridge-utils openbsd-netcat edk2-ovmf
```

---

### **Step 2: Enable Virtualization Support**
Ensure your CPU supports virtualization:
1. Enable **VT-x** (Intel) or **AMD-V** (AMD) in your BIOS/UEFI settings.
2. Verify that your system supports virtualization:
   ```bash
   egrep -o '(vmx|svm)' /proc/cpuinfo
   ```
   If no output appears, you might need to enable it in the BIOS/UEFI.

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

### **Step 4: Set Up Networking**
Libvirt sets up a default network for your virtual machines. To ensure it works:
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
