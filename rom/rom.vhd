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
      0  => "0000000010000011", -- li s2,0;
      1  => "0000000011000011", -- li s3,0;

      2  => "0000000010000101", -- mov A,s2;
      3  => "0000000011000001", -- add A,A,s3;
      4  => "0000000011000100", -- mov s3,A;

      5  => "0000000010000101",  -- mov A,s2;
      6  => "0000001000000010",  -- addi A,A,1;
      7  => "0000000010000100", -- mov s2,A;

      8  => "0011110000000011", -- li s0,30;
      9  => "0011110000001010", -- subi A,A,30
      10  => "1111000000000110", -- bne s2,30,-8   
      -- FAZ A SUBTRAÇÃO COM 30 E CHAMA O COMANDO DA BRANCH, SE A SUBTRAÇÃO FOR ZERO, ATIVA A FLAG E FAZ O BRANCH

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