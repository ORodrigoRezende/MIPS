library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity unidadecontrole is port (
    Opcode : in  STD_LOGIC_VECTOR (5 downto 0);
    RegDst : out STD_LOGIC;
    ALUSrc : out STD_LOGIC;
    MemtoReg : out STD_LOGIC;
    RegWrite : out STD_LOGIC;
    MemRead : out STD_LOGIC;
    MemWrite : out STD_LOGIC;
    Branch : out STD_LOGIC;
    ALUOp : out STD_LOGIC_VECTOR (1 downto 0);
    Jump : out STD_LOGIC
);
end unidadecontrole;

architecture behavioral of unidadecontrole is
begin

process(Opcode)
begin
if    Opcode = "000000" then
  ALUOp    <= "10";
  RegWrite <= '1';
  RegDst   <= '1';
  ALUSrc   <= '0';
  Branch   <= '0';
  MemWrite <= '0';
  MemToReg <= '0';
  Jump     <= '0';
  MemRead  <= '0';
elsif Opcode = "001000" then
  ALUOp    <= "00";
  RegWrite <= '1';
  RegDst   <= '0';
  ALUSrc   <= '1';
  Branch   <= '0';
  MemWrite <= '0';
  MemToReg <= '0';
  Jump     <= '0';
  MemRead  <= '0';
elsif Opcode = "100011" then
  ALUOp    <= "00";
  RegWrite <= '1';
  RegDst   <= '0';
  ALUSrc   <= '1';
  Branch   <= '0';
  MemWrite <= '0';
  MemToReg <= '1';
  Jump     <= '0';
  MemRead  <= '1';
elsif Opcode = "101011" then
  ALUOp    <= "00";
  RegWrite <= '0';
  ALUSrc   <= '1';
  Branch   <= '0';
  MemWrite <= '1';
  Jump     <= '0';
  MemRead  <= '0';
elsif Opcode = "000100" then
  ALUOp    <= "01";
  RegWrite <= '0';
  ALUSrc   <= '0';
  Branch   <= '1';
  MemWrite <= '0';
  Jump     <= '0';
  MemRead  <= '0';
elsif Opcode = "000010" then
  RegWrite <= '0';
  Branch   <= '0';
  MemWrite <= '0';
  Jump     <= '1';
  MemRead  <= '0';
end if;

end behavioral;