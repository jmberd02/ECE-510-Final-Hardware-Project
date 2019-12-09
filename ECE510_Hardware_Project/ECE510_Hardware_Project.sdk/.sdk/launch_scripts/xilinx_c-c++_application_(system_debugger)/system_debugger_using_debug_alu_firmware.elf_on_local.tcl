connect -url tcp:127.0.0.1:3121
configparams mdm-detect-bscan-mask 2
targets -set -nocase -filter {name =~ "microblaze*#0" && bscan=="USER2"  && jtag_cable_name =~ "Digilent Basys3 210183AB4D5CA"} -index 0
rst -processor
targets -set -nocase -filter {name =~ "microblaze*#0" && bscan=="USER2"  && jtag_cable_name =~ "Digilent Basys3 210183AB4D5CA"} -index 0
dow C:/Users/Jacob/source/repos/ECE-510-Final-Hardware-Project/ECE510_Hardware_Project/ECE510_Hardware_Project.sdk/ALU_Firmware/Debug/ALU_Firmware.elf
bpadd -addr &main
