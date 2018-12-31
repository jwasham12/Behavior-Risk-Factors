ods rtf file='C:\Desktop\Project.rtf' ;
/*data step, inputting the dataset for our project*/
data NCHS;
	infile 'C:\Desktop\project\NCHS_-_Age-adjusted_Death_Rates_for_the_Top_10_Leading_Causes_of_Death__United_States__2013.csv' dsd missover firstobs = 2;
	input Year Cause: $60. Cause_name: $30. State: $20. Deaths AADR: 5.;
	if cmiss(of _all_) then delete;
	if Year < 2005 then delete;
	label AADR = 'Age Adjusted Death Rate';
run;
data Risk_Factors; 
	infile 'C:\Desktop\project\Behavioral_Risk_Factors_-_Vision___Eye_Health.csv' dsd missover firstobs = 2; 
	input Year LocationAbbr $ State: $20. Topic: $40. Question: $100. DataSource $ Response $ Data_Value_Unit $
    Data_Value_Type: $30. Data_Value Data_Value_Footnote_Symbol $ Data_Value_Footnote $
	Low_Confidence_limit High_Confidence_Limit Sample_Size Break_Out$ Break_Out_Category$ GeoLocation
	TopicId $ QuestionId$ LocationId BreakOutId $  BreakOutCategoryId $ ResponseId $;
	drop LocationAbbr DataSource Response Data_Value_Unit Data_Value_Footnote_Symbol Data_Value_Footnote Break_Out 
	Break_Out_Category GeoLocation TopicId QuestionId BreakOutId BreakOutCategoryId ResponseId Data_Value;
	if Year > 2013 then delete;
	if cmiss(Sample_Size) then delete; 
	if Sample_Size < 500 then delete;
	Rate = Data_Value/100;
	format Rate percent6.1;
	label Data_Value_Type='Type of Data Value' Data_Value='Data Value' Low_Confidence_limit="Low CI Limit"
	High_Confidence_Limit="High CI Limit" Sample_Size="Sample Size" LocationId='Location ID'; 
run;
/*an overview for the two sets of data*/
title1"First Overview for AADR";
ods select Attributes;
proc contents data = NCHS;
run;
title;
title2"First Overview for Behavior Risk Factors";
ods select Attributes;
proc contents data = Risk_Factors;
run;
/*sort data for merge*/
proc sort data = NCHS out = p1;
	by year State;
run;
proc sort data = Risk_Factors out = p2;
	by year State;
run;
/*merge data*/
data Combined;
	merge p1 p2;
	by year state;
	if cmiss(of _all_) then delete;
run;
/*overview for the merged data*/
title;
title3"First Overview for Merged Data";
proc contents data = Combined;
run;

/*maybe add a proc freq here and talk something about it,
we have univariate for extreme values and proc means already*/
title;
proc freq data=Combined nlevels;
	tables _ALL_/noprint missing;
run;
proc univariate data = Combined;
	var AADR Rate Sample_Size Deaths;
	ods select ExtremeObs;
run;
proc means data = Combined;
 var AADR Rate Sample_Size Deaths;
run;
/*creating new variables called number of patients, by using sample size times the rate*/
data sample_number;
	set Combined;
	Acutal = int(Sample_size * Rate); 
	label Acutal ='Number of Patients';
run;
/* sort by qustion, get an average of rate responding illness, we sort data first*/
proc sort data = combined out = sort_question;
	by question;
run;
/*and then do a loop for our result*/
data average_rate (keep= question rate);
	set sort_question;
	by question;
	if first.question then do
	total_rate = 0;
	number = 0;
	end;
	number + 1;
	total_rate + rate;
	if last.question;
	avg_rate = total_rate/number;
run;

proc print data = average_rate;
run;
*mean analysis on AADR for different questions;
proc means data=sort_question;
var AADR;
by question;
run;
	 *done!;
ods rtf close;
