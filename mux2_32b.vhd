library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux2_32 is port(
    A : in STD_LOGIC_VECTOR(0 TO 31);
    B : in STD_LOGIC_VECTOR(0 TO 31);
    SEL : in STD_LOGIC;
    S : out STD_LOGIC
);
end mux2_32;

architecture Behavioral of mux2_32 is
    component mux2 is port(
        E : in STD_LOGIC_VECTOR(0 TO 1);
        SEL : in STD_LOGIC;
        S : out STD_LOGIC
    );
    end component;

begin
    gen : for i in 0 to 31 generate
        M : mux2_port map (
            E(0) => A(i);
            E(1) => B(i);
            Sel => SEL;
            S => S(i)
        )
    end generate;

end Behavioral;