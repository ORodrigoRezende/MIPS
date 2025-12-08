library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ula32 is port(
    Ainvet  : in  STD_LOGIC;
    Binvert : in  STD_LOGIC;
    A       : in  STD_LOGIC_VECTOR (31 downto 0);
    B       : in  STD_LOGIC_VECTOR (31 downto 0);
    Op      : in  STD_LOGIC_VECTOR (1 downto 0);
    R       : out STD_LOGIC_VECTOR (31 downto 0);
    Zero    : out STD_LOGIC
);
end ula32;

architecture Behavioral of ula32 is
    component ula1 is port(
        op : in STD_LOGIC_VECTOR(1 DOWNTO 0);
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
	end component;
    component portaor32 is
        port (
            E : in  STD_LOGIC_VECTOR (0 to 31);
            S : out  STD_LOGIC
        );
    end component;

    signal sLess : STD_LOGIC;
    signal sOr : STD_LOGIC;
    signal sVai1 : STD_LOGIC_VECTOR (0 to 31);
    signal sR : STD_LOGIC_VECTOR (31 downto 0);
    signal sSet : STD_LOGIC_VECTOR (0 to 30); -- Para evitar warning 
begin 
        ula_0 : ula1 port map (
            op => Op(1 downto 0),
            A => A(0),
            B => B(0),
            Less => sLess,
            Vem1 => Binvert,
            Ainvert => Ainvet,
            Binvert => Binvert,
            R => sR(0),
            Set => sSet(0),
            Vai1 => svai1(0)
        );

        gen_ula : for i in 1 to 30 generate
            ula_n : ula1 port map (
                op => Op(1 downto 0),
                A => A(i),
                B => B(i),
                Less => '0',
                Vem1 => sVai1(i-1),
                Ainvert => Ainvet,
                Binvert => Binvert,
                R => sR(i),
                Set => sSet(i),
                Vai1 => sVai1(i)
            );
        end generate;

        ula_31 : ula1 port map (
            op => Op(1 downto 0),
            A => A(31),
            B => B(31),
            Less => '0',
            Vem1 => sVai1(30),
            Ainvert => Ainvet,
            Binvert => Binvert,
            R => sR(31),
            Set => sLess,
            Vai1 => svai1(31)
        );

        or_32 : portaor32 port map (
            E => sR,
            S => sOr
        ); 

        R <= sR;
        Zero <= NOT sOr;
end Behavioral;