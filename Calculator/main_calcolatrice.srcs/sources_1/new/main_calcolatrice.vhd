library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity main_calcolatrice is
    Port ( swt_num: in std_logic_vector(9 downto 0);--ok
           swt_op: in std_logic_vector(3 downto 0);--ok
           swt_eq: in std_logic;--ok
           y           : in std_logic; --MESSO SU SWT10 segnae che serve per dire se voglio visualizzare le prime 4 cifre del numero o le ultime
           select_out_division  : in std_logic;
           control_signal : in std_logic; --MESSO SU JC0 segnale per scegliere tra visualizazzione in ingresso o in uscita
           reset       : in STD_LOGIC;--ok
           clk         : in STD_LOGIC;--ok
          -- an_input    : out std_logic_vector(3 downto 0); 
          -- in_seven_seg: out std_logic_vector (6 downto 0);
           out_an          : out std_logic_vector (3 downto 0);--ok
           out_code : out STD_LOGIC_VECTOR (6 downto 0);--ok
           dot         : out STD_LOGIC);--ok
end main_calcolatrice;

architecture Behavioral of main_calcolatrice is

component divisore_binario is port(
            clk: in std_logic; 
            num  : in  std_logic_vector(15 downto 0) := (others => '0');  -- Numero da dividere
            den   : in  std_logic_vector(15 downto 0):= (others => '0');  -- Divisore
            q  :   out std_logic_vector(15 downto 0):= (others => '0');  -- Quoziente
            remainder : out std_logic_vector(15 downto 0):= (others => '0')); -- Resto
end component;

component moltiplicatore is port(
            
            n1     : in  std_logic_vector ( 13 downto 0) := (others => '0');
            n2     : in  std_logic_vector ( 13 downto 0) := (others => '0');
            uscita : out std_logic_vector ( 27 downto 0) := (others => '0'));
end component;

component main_seven_segment is port(
            neg         : in std_logic;
            clock_100Mhz: in std_logic;
            reset     :in std_logic;
            bin: in std_logic_vector(27 downto 0);
            y: in  std_logic ;
            dot: out std_logic;
            an: out std_logic_vector (3 downto 0);
            out_seven_seg: out std_logic_vector (6 downto 0);
            operator: in std_logic_vector(1 downto 0));
end component;

component sommatore is port(
            
            a, b : in std_logic_vector(13 downto 0);
            s : out std_logic_vector(27 downto 0));
end component;

component sottrattore is port (
           --reset  : in std_logic;
            neg    : out std_logic;
            n1, n2 : in std_logic_vector(15 downto 0); 
            o : out std_logic_vector(27 downto 0):= (others=>'0'));
end component;

component up_bit_division is port (
            q, remainder : in std_logic_vector(15 downto 0); 
            q_out, rem_out : out std_logic_vector(27 downto 0):= (others=>'0'));
end component;

component mux4_to1 is port (
            select_out : in std_logic_vector(1 downto 0);
            add, mul,div,dif : in std_logic_vector(27 downto 0); 
            out_operation : out std_logic_vector(27 downto 0));
end component;

component demux1_to4 is port (
           in14bit : in STD_LOGIC_VECTOR (13 downto 0);
           add : out STD_LOGIC_VECTOR (13 downto 0);--ok
           mul : out STD_LOGIC_VECTOR (13 downto 0);--ok
           div : out STD_LOGIC_VECTOR (15 downto 0);--ok
           dif : out STD_LOGIC_VECTOR (15 downto 0);--ok
           select_out : in STD_LOGIC_VECTOR (1 downto 0));
end component;

component top_writing_input is port (
          clk: in std_logic;
          swt_num: in std_logic_vector(9 downto 0);
          swt_op: in std_logic_vector(3 downto 0);
          swt_eq: in std_logic;
          btn_reset: in std_logic;
          bin1, bin2: out std_logic_vector(13 downto 0):=(others=>'0');
          operator: out std_logic_vector(1 downto 0);
          an: out std_logic_vector(3 downto 0); 
          out_seven_seg: out std_logic_vector (6 downto 0);
          finished_reading: out std_logic
            );
end component; 

component mux2_to1_display is port(
           clk, control_signal : in STD_LOGIC;
           an_input : in STD_LOGIC_VECTOR (3 downto 0);
           an_output : in STD_LOGIC_VECTOR (3 downto 0);
           in_seven_segment : in STD_LOGIC_VECTOR (6 downto 0);
           out_seven_segment : in STD_LOGIC_VECTOR (6 downto 0);
           out_an : out STD_LOGIC_VECTOR (3 downto 0);
           out_code : out STD_LOGIC_VECTOR (6 downto 0));
end component;

component mux2_to1_division is
    Port ( q_in : in STD_LOGIC_VECTOR (27 downto 0);
           remainder_in : in STD_LOGIC_VECTOR (27 downto 0);
           out_division : out STD_LOGIC_VECTOR (27 downto 0);
           select_out : in STD_LOGIC);
end component;
signal number11, number22 : std_logic_vector(13 downto 0); -- mi servono per trasportare i due numeri
signal select_out : STD_LOGIC_VECTOR (1 downto 0);

signal n_add1, n_mul1, n_add2,n_mul2 : std_logic_vector(13 downto 0);
signal n_div1,n_div2 : std_logic_vector(15 downto 0);
signal n_dif1,n_dif2 : std_logic_vector(15 downto 0);

signal neg, finished_reading, reset_div, ctrl: std_logic:='0';

signal o_add, o_mul,o_dif : std_logic_vector(27 downto 0);
signal o_div1,o_div2 :std_logic_vector(15 downto 0);
signal o_div128, o_div228, o_div28 :std_logic_vector(27 downto 0);

signal bin :std_logic_vector(27 downto 0);

signal an, an_input :std_logic_vector(3 downto 0);
signal in_seven_seg, out_seven_segment : std_logic_vector(6 downto 0);
begin



input_keyboard : top_writing_input port map(
           clk => clk,
           swt_num => swt_num,
           swt_op => swt_op,
           swt_eq => swt_eq,
           btn_reset => reset,
           bin1 => number11,
           bin2 => number22,
           operator => select_out,
           an => an_input,
           out_seven_seg => in_seven_seg,
           finished_reading=>finished_reading
           );

demux1 : demux1_to4 port map(
           in14bit => number11,
           add => n_add1,
           mul=> n_mul1,
           div => n_div1,
           dif => n_dif1,
           select_out => select_out
           );
           
demux2 : demux1_to4 port map(
           in14bit => number22,
           add => n_add2,
           mul=>n_mul2,
           div => n_div2,
           dif => n_dif2,
           select_out => select_out
           );
multiplier : moltiplicatore port map (
          
           n1 => n_mul1,
           n2 => n_mul2,
           uscita => o_mul
           );
           
adder : sommatore port map(
            
            a => n_add1,
            b => n_add2,
            s => o_add
            );
            
subtractor : sottrattore port map(
       --  reset => reset, 
           neg => neg,
           n1 => n_dif1,
           n2 => n_dif2,
           o => o_dif
           );
           
division : divisore_binario port map(
           clk => clk,
           num => n_div1,
           den => n_div2,
           q   => o_div1,
           remainder => o_div2
           );
           
u_up_bit_division : up_bit_division port map (
            q => o_div1,
            remainder => o_div2,
            q_out =>o_div128,
            rem_out=>o_div228
            ); 

mux1 : mux2_to1_division port map (
           q_in =>o_div128,
           remainder_in => o_div228,
           select_out => select_out_division,
           out_division => o_div28
           );    
            
mux2 : mux4_to1 port map(
           select_out => select_out,
           add => o_add,
           mul => o_mul,
           div => o_div28,
           dif => o_dif,
           out_operation => bin
           );
           
mux3 : mux2_to1_display port map(
           clk => clk,
           control_signal => control_signal,
           an_input => an_input,
           an_output => an,
           in_seven_segment => in_seven_seg,
           out_seven_segment => out_seven_segment,
           out_an => out_an,
           out_code => out_code
           );
                    
decoder_display :main_seven_segment port map(
           neg => neg,
           clock_100Mhz => clk,
           reset => reset,
           bin => bin,
           y =>y,
           dot => dot,
           an => an,
           out_seven_seg => out_seven_segment,
           operator => select_out
           );
end Behavioral;
