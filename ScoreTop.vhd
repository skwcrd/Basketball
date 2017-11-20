Library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

Entity ScoreTop is
Port(
	CLK,Rstb : in std_logic;
	iPush1,iPush2,iPush3 : in std_logic;
	Change : in std_logic;
	oLEDT1 : out std_logic_vector(3 downto 0);
	oLEDT2 : out std_logic_vector(3 downto 0);
	oData : out std_logic_vector(3 downto 0);
	com : out std_logic_vector(3 downto 0)
);
End ScoreTop;

Architecture Structural of ScoreTop is
	
	Component CLK1ms is
	Port(
		CLK : in std_logic;
		Rstb : in std_logic;
		o1ms : out std_logic
	);
	End Component CLK1ms;
	
	Component CLKhalfsec is
	Port(
		CLK : in std_logic;
		Rstb : in std_logic;
		i1ms : in std_logic;
		o0_5s : out std_logic
	);
	End Component CLKhalfsec;
	
	Component ScanDigit_score is
	Port(
		CLK : in std_logic;
		Rstb : in std_logic;
		i1ms : in std_logic;
		iDigit1 : in std_logic_vector(3 downto 0);
		iDigit2 : in std_logic_vector(3 downto 0);
		iDigit3 : in std_logic_vector(3 downto 0);
		iDigit4 : in std_logic_vector(3 downto 0);
		oDigit : out std_logic_vector(3 downto 0);
		oData : out std_logic_vector(3 downto 0)
	);
	End Component ScanDigit_score;
	
	Component FSM_Push is
	Port(
		CLK,Rstb : in std_logic;
		I : in std_logic;
		iPush1,iPush2,iPush3 : in std_logic;
		oT1Push1,oT1Push2,oT1Push3 : out std_logic;
		oT2Push1,oT2Push2,oT2Push3 : out std_logic
	);
	End Component FSM_Push;
	
	Component FSM_COM is
	Port(
		CLK,Rstb : in std_logic;
		i1s : in std_logic;
		I : in std_logic;
		iCOM : in std_logic_vector(3 downto 0);
		com : out std_logic_vector(3 downto 0)
	);
	End Component FSM_COM;
	
	Component Counter is
	Port(
		CLK,Rstb : in std_logic;
		iP1,iP2,iP3 : in std_logic;
		oDigit1,oDigit2 : out std_logic_vector(3 downto 0);
		oLED : out std_logic_vector(3 downto 0)
	);
	End Component Counter;
	
	signal w1ms,w0_5s : std_logic;
	signal wT1Push1,wT1Push2,wT1Push3 : std_logic;
	signal wT2Push1,wT2Push2,wT2Push3 : std_logic;
	signal wDigit1,wDigit2,wDigit3,wDigit4 : std_logic_vector(3 downto 0);
	signal wCOM : std_logic_vector(3 downto 0);
Begin

	u_CLK1ms : CLK1ms
	Port Map(
		CLK	=> CLK,
		Rstb	=> Rstb,
		o1ms	=> w1ms
	);
	
	u_CLK0_5s : CLKhalfsec
	Port Map(
		CLK	=> CLK,
		Rstb	=> Rstb,
		i1ms	=> w1ms,
		o0_5s	=> w0_5s
	);
	
	u_Team1 : Counter
	Port Map(
		CLK		=> CLK,
		Rstb		=> Rstb,
		iP1		=> wT1Push1,
		iP2		=> wT1Push2,
		iP3		=> wT1Push3,
		oDigit1	=> wDigit1,
		oDigit2	=> wDigit2,
		oLED		=> oLEDT1
	);
	
	u_Team2 : Counter
	Port Map(
		CLK		=> CLK,
		Rstb		=> Rstb,
		iP1		=> wT2Push1,
		iP2		=> wT2Push2,
		iP3		=> wT2Push3,
		oDigit1	=> wDigit3,
		oDigit2	=> wDigit4,
		oLED		=> oLEDT2
	);
	
	u_FSMpush : FSM_Push
	Port Map(
		CLK		=> CLK,
		Rstb		=> Rstb,
		I			=> Change,
		iPush1	=> iPush1,
		iPush2	=> iPush2,
		iPush3	=> iPush3,
		oT1Push1	=> wT1Push1,
		oT1Push2	=> wT1Push2,
		oT1Push3	=> wT1Push3,
		oT2Push1	=> wT2Push1,
		oT2Push2	=> wT2Push2,
		oT2Push3	=> wT2Push3
	);
	
	u_FSMcom : FSM_COM
	Port Map(
		CLK	=> CLK,
		Rstb	=> Rstb,
		i1s	=> w1s,
		I		=> wChange,
		iCOM	=> wCOM,
		com	=> com
	);
	
	u_ScanDigit : ScanDigit_score
	Port Map(
		CLK		=> CLK,
		Rstb		=> Rstb,
		i1ms		=> w1ms,
		iDigit1	=> wDigit1,
		iDigit2	=> wDigit2,
		iDigit3	=> wDigit3,
		iDigit4	=> wDigit4,
		oDigit	=> wCOM,
		oData		=> oData
	);

End Structural;
