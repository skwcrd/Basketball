Library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

Entity FSM_top is
Port(
	CLK,Rstb : in std_logic;
	I : in std_logic;
	iPush1,iPush2,iPush3,iPush4 : in std_logic;
	iDataTime,iDataScore : in std_logic_vector(3 downto 0);
	iComTime,iComScore : in std_logic_vector(3 downto 0);
	idp : in std_logic;
	iLEDtime,iLEDscore : in std_logic_vector(7 downto 0);
	oPush1Time,oPush2Time,oPush3Time,oPush4Time : out std_logic;
	oPush1Score,oPush2Score,oPush3Score,oPush4Score : out std_logic;
	oLED : out std_logic_vector(7 downto 0);
	oData : out std_logic_vector(3 downto 0);
	com : out std_logic_vector(3 downto 0);
	dp : out std_logic
);
End FSM_top;

Architecture Behavioral of FSM_top is
	type State_Type is (State_Time,State_Score);
	signal state : State_Type;
Begin

	---------- REGISTOR/CHANGE STATE ----------
	u_rState : Process(CLK,Rstb,I)
	Begin
		if(Rstb='0') then
			state <= State_Time;
		elsif(rising_edge(CLK)) then
			if(I='1') then
				state <= State_Score;
			elsif(I='0') then
				state <= State_Time;
			else
				state <= state;
			end if;
		else
			state <= state;
		end if;
	End Process;
	
	---------- OUTPUT STATE DIGIT ----------
	u_oState : Process(CLK)
	Begin
		if(rising_edge(CLK)) then
			case state is
				when State_Time =>	oPush1Time <= iPush1;
											oPush2Time <= iPush2;
											oPush3Time <= iPush3;
											oPush4Time <= iPush4;
											oPush1Score <= '0';
											oPush2Score <= '0';
											oPush3Score <= '0';
											oPush4Score <= '0';
											oLED <= iLEDtime;
											oData <= iDataTime;
											com <= iComTime;
											dp <= idp;
											
				when State_Score =>	oPush1Score <= iPush1;
											oPush2Score <= iPush2;
											oPush3Score <= iPush3;
											oPush4Score <= iPush4;
											oPush1Time <= '0';
											oPush2Time <= '0';
											oPush3Time <= '0';
											oPush4Time <= '0';
											oLED <= iLEDscore;
											oData <= iDataScore;
											com <= iComScore;
											dp <= '0';
			end case;
		end if;
	End Process;

End Behavioral;

