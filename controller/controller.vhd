library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity controller is
    port (   
        jump_en : out std_logic;
        clk, reset : in std_logic;
        data_in : in unsigned(6 downto 0);
        adress_out :  out unsigned(6 downto 0);
        instruction : in unsigned(15 downto 0)
    );  
 end entity;

 architecture a_controller of controller is
    component stateMachine is
        port(
            clk : in std_logic;
            reset : in std_logic;
            state_out : out std_logic
        );
    end component;

    signal opcode: unsigned(3 downto 0);
    signal state : std_logic;
    
    begin
        state_machine : stateMachine PORT MAP(clk => clk, reset => reset, state_out => state);

        opcode <= instruction(3 downto 0);
        jump_en <=  '1' when opcode="1111" else '0'; 

        adress_out <= data_in when state = '0' else data_in + 1;
            
 end architecture;