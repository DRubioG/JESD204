library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;

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

begin

--    scrambler <= data_in(15) xor data_in(14);


    data_out <= data_in xor scrambler;

end arch_scrambler;
