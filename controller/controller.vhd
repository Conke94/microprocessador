library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity controller is
    port (   
        jump_en : out std_logic;
        clk, reset : in std_logic;
        operation: out unsigned(1 downto 0);
        last_adress : in unsigned(6 downto 0);
        adress_out :  out unsigned(6 downto 0);
        instruction : in unsigned(15 downto 0);
        registrador : out unsigned(2 downto 0)
    );  
 end entity;

 architecture a_controller of controller is
    component state_machine is
        port(
            clk, reset : in std_logic;
            state : out unsigned(1 downto 0)
        );
    end component;

    signal opcode: unsigned(3 downto 0);
    signal jump : std_logic;
    signal state : unsigned(1 downto 0);
    
    begin
        state_mach : state_machine PORT MAP(clk, reset, state);

        opcode <= instruction(3 downto 0);
        registrador <= instruction(8 downto 6);

        operation <= "00" when opcode = "0001" or opcode = "0010" else
                     "01" when opcode = "1001" or opcode = "1010" else
                     "00";

        jump <= '1' when opcode="1111" else '0'; 
        jump_en <= jump;

        adress_out <= last_adress + 1 when jump = '0' and state = "10" else 
                      instruction(15 downto 9) when state = "10" else
                      last_adress;
 end architecture;