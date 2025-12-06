library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ula1 is port(
    op : in STD_LOGIC_VECTOR(0 TO 1);
    A : in STD_LOGIC;
    B : in STD_LOGIC;
    Less : in STD_LOGIC;
    Vem1 : in STD_LOGIC;
    Ainvert : in STD_LOGIC;
    Binvert : in STD_LOGIC;
    R : out STD_LOGIC;
    Set : out STD_LOGIC;
    Vai1 : out STD_LOGIC
);

end ula1;

architecture Behavioral of ula1 is

    component mux2 is port(
        E : in STD_LOGIC_VECTOR(0 TO 1);
        SEL : in STD_LOGIC;
        S : out STD_LOGIC
    );
    end component;

    component mux4 is port(
        E : in STD_LOGIC_VECTOR(0 TO 3);
        SEL : in STD_LOGIC_VECTOR(1 DOWNTO 0);
        S : out STD_LOGIC
    );
    end component;

    component somadorcompleto is port(
    A : in STD_LOGIC;
    B : in STD_LOGIC;
    Vem1 : in STD_LOGIC;
    S : out STD_LOGIC;
    Vai1 : out STD_LOGIC
    );
    end component;

    signal SnotA, SnotB, SMux1, SMux2 , SAnd, SOr, SSoma : STD_LOGIC;

begin
    SnotA <= NOT A;
    SnotB <= NOT B;

    M1 : mux2 port map (
        E(0) => A,
        E(1) => SnotA,
        SEL => Ainvert,
        S => SMux1
    );

    M2 : mux2 port map (
        E(0) => B,
        E(1) => SnotB,
        SEL => Binvert,
        S => SMux2
    );
    SAnd <= SMux1 AND SMux2;
    SOr <= SMux1 OR SMux2;
    
    somador : somadorcompleto port map (
        A => SMux1,
        B => SMux2,
        Vem1 => Vem1,
        S => SSoma,
        Vai1 => Vai1
    );

    M3 : mux4 port map (
        E(0) => SAnd,
        E(1) => SOr,
        E(2) => SSoma,
        E(3) => Less,
        SEL => op,
        S => R
    );
    Set <= SSoma;
    
end Behavioral;
