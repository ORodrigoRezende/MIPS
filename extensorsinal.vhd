library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity extensorsinal is port (
    E : in  STD_LOGIC_VECTOR (15 downto 0);
    S : out  STD_LOGIC_VECTOR (31 downto 0)
);
end extensorsinal;

architecture Behavioral of extensorsinal is
begin
    S(15 downto 0) <= E;
    gen : for i in 31 downto 16 generate
        S(i) <= E(15);
    end generate;
end Behavioral;