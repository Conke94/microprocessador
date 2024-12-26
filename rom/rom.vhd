library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom is
   port( 
      clk      : in std_logic;
      endereco : in unsigned(6 downto 0);
      dado     : out unsigned(15 downto 0) 
   );
end entity;
architecture a_rom of rom is
   type mem is array (0 to 127) of unsigned(15 downto 0);

   constant conteudo_rom : mem := (
      -- Salva os números na memória
      0  => "0000001000000011", -- li s0,1
      1  => "0100001001000011", -- li s1,33
      2  => "0000000000000101", -- mov A,s0
      3  => "0000000000001100", -- sw A,$s0
      4  => "0000001000000010", -- addi 1
      5  => "0000000000000100", -- mov s0,A
      6  => "0000000001001000", -- cmpr A,s1
      7  => "1111011000000110", -- bne -5

      -- Pega o próximo número primo
      8  => "0000001000000011", -- li s0,1
      9  => "0100001001000011", -- li s1,33
      10 => "0000000000000101", -- mov A,s0
      11 => "0000001000000010", -- addi 1
      12 => "0000000000000100", -- mov s0,A
      13 => "0000000000001011", -- lw A,$s0
      14 => "0000000010000100", -- mov s2,A
      15 => "0000000000001000", -- cmpr s0,A
      16 => "1111010000000110", -- bne -6

      -- Tira todos os múltiplos
      17 => "0000000010000101", -- mov A,s2
      18 => "0000000100000100", -- mov s4,A
      19 => "0000000100000101", -- mov A,s4
      20 => "0000000010000001", -- add A,A,s2
      21 => "0000000100000100", -- mov s4,A 
      22 => "0000000011000011", -- li s3,0
      23 => "0000000011000101", -- mov A,s3
      24 => "0000000100001100", -- sw A,$s4
      25 => "0000000100000101", -- mov A,s4
      26 => "0000000001001001", -- sub A,s1
      27 => "1110111000000111", -- bcs -9

      -- Finalização do loop
      28 => "0000000000000101", -- mov A,s0
      29 => "0000000001001000", -- cmpr A,s1
      30 => "1101100000000110", -- bne -20
      others => (others=>'0')
   );
begin
   process(clk)
   begin
      if(rising_edge(clk)) then
         dado <= conteudo_rom(to_integer(endereco));
      end if;
   end process;
end architecture;