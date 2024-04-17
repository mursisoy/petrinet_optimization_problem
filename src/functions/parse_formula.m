function F = parse_formula()
% parse Boolean formula (F) given in Conjunctive normal form
% formula is a string of characters
% connectives: & - conjunction, | - disjunction, ! - negation
% literals: small or caps letters (a-z, A-Z) (small letters will mean requirement in final state, caps along trajectory)
%example of formula: 'A&(b|!c)&(!C|!D)&(!a)'

fprintf('\nInput Boolean formula in Conjunctive Normal Form;\n\tUse & , | , ! for conjunction, disjunction and negation, respectively;\n');
fprintf('\tUse letters for atomic propositions; upper case letter means restriction along trajectory, lower case restriction in final state.\n');

F = input('Formula: \n', 's');

F=strrep(F,' ',''); %remove spaces
F=strrep(F,'''',''); %remove apostrophes (if there are at beginning/end)

% [D,F]=strtok(F,'&');    %D is current disjunction, F is remainder (F now begins with "&")

D=textscan(F,'%s','delimiter','&');  %separate disjunctions in cell D
D=D{1}; %D{i} will be a char string for i^th disj.

for i=1:length(D)   %current disjunction is string D{i}
    D{i}=strrep(D{i},'(',''); %remove paranthesis (may be only at first and last positions)
    D{i}=strrep(D{i},')','');
    disj=textscan(D{i},'%s','delimiter','|');  %elements of currrent disjunction (each is literal or negated literal, because F is in CNF)
    disj=disj{1};
    %find restrictions in current disjunction:
    fprintf('\nDisjunction %d:\n',i);
    for j=1:length(disj)    %current literal is disj{j}
        if length(disj{j})>2 || length(disj{j})==0    %tests for something wrong in input form
            fprintf('\n ERROR - please input formula in Closed Normal Form (conjunction of disjunctions, where negation can precede at most once a literal.\n');
            fprintf('%s',disj{j});
            return;
        elseif length(disj{j})==2 && ~(disj{j}(1)=='!' && isletter(disj{j}(2)))
            fprintf('\n ERROR - no letter or negation in disjunction "%s".\n',disj{j});
            return;
        elseif length(disj{j})==1 && ~isletter(disj{j}(1))
            fprintf('\n ERROR - no letter in disjunction "%s".\n',disj{j});
            return;
        end
        
        %find restrinction in part (literal) j of disjunction D{i}:
        if length(disj{j})==1   %non-negated letter (atomic proposition
            if isstrprop(disj{j}(1),'lower')    %lower case letter -> final state restriction
                prop_ind=disj{j}(1)-'a'+1;  %index of proposition
                fprintf('\tAtomic prop. %d should be TRUE in final state\n',prop_ind);
                
            elseif isstrprop(disj{j}(1),'upper')    %upper case letter -> restriction along trajectory
                prop_ind=disj{j}(1)-'A'+1;  %index of proposition
                fprintf('\tAtomic prop. %d should be TRUE along traj.\n',prop_ind);
                
            else
                fprintf('\nERROR - no letter in disjunction "%s"\n',disj{j});
                return;
            end
            
        else % length(disj{j})==2 && disj{j}(1)=='!'  %negation
            if isstrprop(disj{j}(2),'lower')    %lower case letter -> final state restriction
                prop_ind=disj{j}(2)-'a'+1;  %index of proposition
                fprintf('\tAtomic prop. %d should be FALSE in final state\n',prop_ind);
                
            elseif isstrprop(disj{j}(2),'upper')    %upper case letter -> restriction along trajectory
                prop_ind=disj{j}(2)-'A'+1;  %index of proposition
                fprintf('\tAtomic prop. %d should be FALSE along traj.\n',prop_ind);
                
            else
                fprintf('\nERROR - no letter in disjunction "%s"\n',disj{j});
                return;
            end
        end
    end
end
 