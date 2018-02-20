transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Organizasyon/FinalProject {C:/Organizasyon/FinalProject/mips_alu.v}
vlog -vlog01compat -work work +incdir+C:/Organizasyon/FinalProject {C:/Organizasyon/FinalProject/mips_core.v}
vlog -vlog01compat -work work +incdir+C:/Organizasyon/FinalProject {C:/Organizasyon/FinalProject/mips_control.v}
vlog -vlog01compat -work work +incdir+C:/Organizasyon/FinalProject {C:/Organizasyon/FinalProject/mips_registers.v}
vlog -vlog01compat -work work +incdir+C:/Organizasyon/FinalProject {C:/Organizasyon/FinalProject/mips_instr_mem.v}
vlog -vlog01compat -work work +incdir+C:/Organizasyon/FinalProject {C:/Organizasyon/FinalProject/mips_data_mem.v}

