library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux2 is
    Port ( E : in STD_LOGIC_VECTOR(0 TO 1);
           SEL : in STD_LOGIC;
           S : out STD_LOGIC);
end mux2;

architecture Behavioral of mux2 is
begin
    S <= (E(0) AND NOT SEL) OR (E(1) AND SEL);
end Behavioral;
