library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity meiosomador is port(
    A : in STD_LOGIC;
    B : in STD_LOGIC;
    S : out STD_LOGIC;
    Vai1 : out STD_LOGIC
);
end meiosomador;

architecture Behavioral of meiosomador is
begin
    S <= A XOR B;
    Vai1 <= A AND B;
end Behavioral;