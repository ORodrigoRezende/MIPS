library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity registrador32 is port (
    D : in  STD_LOGIC_VECTOR (31 downto 0);
    Clear : in  STD_LOGIC;
    Preset : in  STD_LOGIC;
    Enable : in  STD_LOGIC;
    CLK : in  STD_LOGIC;
    Q : out  STD_LOGIC_VECTOR (31 downto 0)
);
end registrador32;

architecture Behavioral of registrador32 is
    component flipflopd is port (
        D     : in  STD_LOGIC;
        Clear : in  STD_LOGIC;
        Preset : in  STD_LOGIC;
        Enable : in  STD_LOGIC;
        CLK   : in  STD_LOGIC;
        Q     : out STD_LOGIC
    );
    end component;
begin
    gen_flipflops: for i in 31 downto 0 generate
        FF : flipflopd port map (
            D => D(i),
            Clear => Clear,
            Preset => Preset,
            Enable => Enable,
            CLK => CLK,
            Q => Q(i)
        );
    end generate;
end Behavioral;

    