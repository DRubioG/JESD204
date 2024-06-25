library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity descrambler is
    Port ( 
        clk : in std_logic;
        rst_n : in std_logic;
        data_in : in std_logic_vector(15 downto 0);
        data_out : out std_logic_vector(15 downto 0)
    );
end descrambler;

architecture arch_descrambler of descrambler is

signal data_out_aux : std_logic_vector(15 downto 0);
signal first_epoch : std_logic_vector(15 downto 0);
signal dff_aux : std_logic_vector(14 downto 0);

begin

    data_out <= data_out_aux;
    
impl_data_out : for i in 0 to 15 generate
        data_out_aux(i) <= data_in(i) xor first_epoch(i);
    end generate;

    first_epoch(0) <= data_in(15) xor data_in(14);
    first_epoch(1) <= data_in(5) xor dff_aux(0);
    
impl_first_epoch : for j in 2 to 15 generate
        first_epoch(j) <= dff_aux(j-2) xor dff_aux(j-1);
    end generate;
    
    process(clk, rst_n)
    begin
        if rst_n = '0' then
            dff_aux <= (others=>'0');
        elsif rising_edge(clk) then
            dff_aux <= data_in(dff_aux'length-1 downto 0);
        end if;
    end process;

end arch_descrambler;
