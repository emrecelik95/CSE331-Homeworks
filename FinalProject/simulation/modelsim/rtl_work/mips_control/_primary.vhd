library verilog;
use verilog.vl_types.all;
entity mips_control is
    port(
        op              : in     vl_logic_vector(5 downto 0);
        fn              : in     vl_logic_vector(5 downto 0);
        clk             : in     vl_logic;
        write_reg       : out    vl_logic_vector(4 downto 0);
        sig_branch      : out    vl_logic;
        sig_mem_read    : out    vl_logic;
        sig_mem_write   : out    vl_logic;
        sig_mem_to_reg  : out    vl_logic;
        sig_reg_write   : out    vl_logic;
        pc_source       : out    vl_logic;
        rd              : out    vl_logic_vector(4 downto 0);
        rt              : out    vl_logic_vector(4 downto 0);
        sig_sb          : out    vl_logic;
        sig_sh          : out    vl_logic
    );
end mips_control;
