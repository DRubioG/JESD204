library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity scrambler is
    Port ( 
        clk : in std_logic;
        rst_n : in std_logic;
        data_in : in std_logic_vector(15 downto 0);
        data_out : out std_logic_vector(15 downto 0)
    );
end scrambler;

architecture arch_scrambler of scrambler is

signal scrambler : std_logic_vector(15 downto 0);
signal first_epoch : std_logic_vector(15 downto 0);
signal dff_aux : std_logic_vector(14 downto 0);
signal data_out_aux : std_logic_vector(15 downto 0);

begin


    data_out <= data_out_aux;


        first_epoch(0) <= data_in(0) xor data_out_aux(14);
        first_epoch(1) <= data_in(1) xor data_out_aux(15);
    
    impl_first_epoch : for i in 2 to 15 generate
            first_epoch(i) <= data_in(i) xor dff_aux(i-2);
        end generate;
        
        data_out_aux(0) <= first_epoch(0) xor data_out_aux(15);
       
    impl_second_epoch : for j in 1 to 15 generate
            data_out_aux(j) <= first_epoch(j) xor dff_aux(j-1);
        end generate;
        
    
    process(clk, rst_n)
    begin
        if rst_n = '0' then
            dff_aux <= (others=>'0');
        elsif rising_edge(clk) then
            dff_aux <= data_out_aux(dff_aux'length-1 downto 0);
        end if;
    end process;

end arch_scrambler;
