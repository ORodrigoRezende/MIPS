library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity decodificador2_4 is port (
    A : in  STD_LOGIC_VECTOR (1 downto 0);
    E : in  STD_LOGIC;
    S : out  STD_LOGIC_VECTOR (0 to 3)
);
end decodificador2_4;

architecture Behavioral of decodificador2_4 is
begin
    S(0) <= not A(1) and not A(0) and E;
    S(1) <= not A(1) and A(0) and E;
    S(2) <= A(1) and not A(0) and E;
    S(3) <= A(1) and A(0) and E;
end Behavioral;