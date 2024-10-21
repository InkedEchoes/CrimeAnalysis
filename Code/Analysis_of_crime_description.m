% 3.4.2 Secondary Description
% Plot the crime description of 2023 using a wordcloud. 
% Crime description offers more details than primary type, and 
% we want to use a wordcloud to see the specific characteristics of crime 
% in Chicago. When implementing, you 
% should consider each description as an element in the wordcloud.
original_data_2023 = readtable('Crimes_2023.csv', 'Delimiter', ',');

% Extract the descriptions
descriptions_data = original_data_2023{:, 7};
num = size(original_data_2023, 1);

descriptions = {};
descriptions_num = 1;
descriptions{1, 1} = descriptions_data{1, 1};
count = zeros(num, 1);
count(1, 1) = 1;

%find unique descriptions
for i = 2:num
    current_description = descriptions_data{i, 1};
    is_new_type = true;
    for j = 1:descriptions_num
        if strcmp(current_description, descriptions{1, j}) == 1
            is_new_type = false;
            count(j, 1) = count(j, 1) + 1;
            break;
        end
    end
    if is_new_type
        descriptions_num = descriptions_num + 1;
        descriptions{1, descriptions_num} = current_description;
        count(descriptions_num, 1) = 1;
    end   
end
count = count(1:descriptions_num);

descriptions_table = table(descriptions', count, 'VariableNames', {'Description', 'Count'});

figure
fig = wordcloud(descriptions_table,'Description','Count');
title("Crime Description Word Cloud");

formatSpec = "Created %s";
tNow = datestr(now);
dim = [.13,0,.07,.07];
str = {sprintf(formatSpec, tNow)}; 
annotation('textbox',dim,'String',str,'FitBoxToText','on');

saveas(fig,'Crime_description_wordcloud.jpg');


