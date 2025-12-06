library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity somadorcompleto is port(
    A : in STD_LOGIC;
    B : in STD_LOGIC;
    Vem1 : in STD_LOGIC;
    S : out STD_LOGIC;
    Vai1 : out STD_LOGIC
);
end somadorcompleto;
architecture Behavioral of somadorcompleto is

    component meiosomador is port(
        A : in STD_LOGIC;
        B : in STD_LOGIC;
        S : out STD_LOGIC;
        Vai1 : out STD_LOGIC
    );
    end component;
    signal S1,S2,V1,V2 : STD_LOGIC;
begin
    somador1 : meiosomador port map (
        A => A,
        B => B,
        S => S1,
        Vai1 => V1
    );
    somador2: meiosomador port map (
        A => S1,
        B => Vem1,
        S => S2,
        Vai1 => V2
    );
    S <= S2;
    Vai1 <= V1 OR V2;
end Behavioral;