library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity deslocador is port (
    E : in  STD_LOGIC_VECTOR (31 downto 0);
    S : out  STD_LOGIC_VECTOR (31 downto 0)
);
end deslocador;

architecture Behavioral of deslocador is
begin
    S(31 downto 2) <= E(29 downto 0);
    S(0)<= '0';
    S(1)<= '0';
end Behavioral;