library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity flipflod_subida is port (
    D     : in  STD_LOGIC;
    Clear : in  STD_LOGIC;
    Preset : in  STD_LOGIC;
    Enable : in  STD_LOGIC;
    CLK   : in  STD_LOGIC;
    Q     : out STD_LOGIC;
);
end flipflod_subida;

architecture Behavioral of flipflod is
begin
    process (CLK, Clear, Preset)
        variable vQ : STD_LOGIC := '0';
    begin
        if Preset = '1' then
            vQ <= '1';
        elsif Clear = '1' then
            vQ <= '0';
        elsif rising_edge(CLK) and Enable = '1' then
            vQ <= D;
        end if;
        Q <= vQ;
    end process;
end Behavioral;