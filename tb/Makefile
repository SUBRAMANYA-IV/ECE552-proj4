# Assemble your RV32I assembly file into an object file
riscv64-unknown-elf-as -march=rv32i -mabi=ilp32 01add.asm -o 01add.o

# Link it into an ELF executable (no standard library)
riscv64-unknown-elf-ld -o 01add.elf 01add.o

# Convert ELF → raw binary (for loading into your CPU)
riscv64-unknown-elf-objcopy -O binary 01add.elf 01add.bin

# OR, for Verilog $readmemh
riscv64-unknown-elf-objcopy -O verilog 01add.elf 01add.hex

