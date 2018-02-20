library verilog;
use verilog.vl_types.all;
entity mips_alu is
    port(
        aluOut          : out    vl_logic_vector(31 downto 0);
        rsCont          : in     vl_logic_vector(31 downto 0);
        rtCont          : in     vl_logic_vector(31 downto 0);
        op              : in     vl_logic_vector(5 downto 0);
        fn              : in     vl_logic_vector(5 downto 0);
        sa              : in     vl_logic_vector(4 downto 0);
        imm             : in     vl_logic_vector(15 downto 0)
    );
end mips_alu;
