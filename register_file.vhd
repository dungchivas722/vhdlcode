library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use WORK.Sys_Definition.ALL;
entity register_file is
    Port ( reset : in STD_LOGIC;
           clk : in STD_LOGIC;
           RFin : in STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);
           RFwa : in STD_LOGIC_VECTOR (ADDR_WIDTH - 1 downto 0);
           RFwe : in STD_LOGIC;
           OPr1a : in STD_LOGIC_VECTOR (ADDR_WIDTH - 1 downto 0);
           OPr1e : in STD_LOGIC;
           OPr2a : in STD_LOGIC_VECTOR (ADDR_WIDTH - 1 downto 0);
           OPr2e : in STD_LOGIC;
           OPr1 : out STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);
           OPr2 : out STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0));
end register_file;
architecture register_file of register_file is
    type DATA_ARRAY is array (integer range<>) of STD_LOGIC_VECTOR(DATA_WIDTH - 1 downto 0);
    signal RF : DATA_ARRAY(0 to 15) := (others => (others => '0'));
begin
    RW_Proc: process(clk, reset)
    begin
        if reset = '0' then
            OPr1 <= (others => '0');
            OPr2 <= (others => '0');
            RF <= (others => (others =>'0'));
        elsif clk'event and clk = '1' then
            if RFwe = '1'then
		RF(conv_integer(RFwa)) <= RFin;
            end if;
            if OPr1e = '1'then
                OPr1 <= RF(conv_integer(OPr1a));
            end if;
            if OPr2e = '1' then
                OPr2 <= RF(conv_integer(OPr2a));
            end if;
        end if;
    end process RW_Proc;
end register_file;
