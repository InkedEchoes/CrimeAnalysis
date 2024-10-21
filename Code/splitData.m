function splitData(filename)
fopen(filename,'r');  % filename = input('','s');

table = readtable(filename,'Delimiter',',');
headers = table.Properties.VariableNames; % read the table and separate the variables by ','

date_table = table(:, 3);  % extract the column of the dates
num = size(date_table, 1);  % count the number of rows


fopen('Crimes_2013_to_2023.csv','w+');
fopen('Crimes_2023.csv','w+');
fopen('Crimes_2024.csv','w+');

% set the headers of the ouput files the same as the original file
writecell(headers, 'Crimes_2013_to_2023.csv');
writecell(headers, 'Crimes_2023.csv');
writecell(headers, 'Crimes_2024.csv');

for j = 1:num
    % extract the year num 
    current_year = date_table{j, 1};  
    date_component = current_year{1}(7:11); 

    year = str2num(date_component);
    if year>= 2013 && year < 2023
        writetable(table(j,:), 'Crimes_2013_to_2023.csv' , 'WriteMode', 'append', 'WriteVariableNames', false);
    elseif year == 2013
        writetable(table(j,:),  'Crimes_2023.csv', 'WriteMode', 'append', 'WriteVariableNames', false);
    elseif year==2024
        writetable(table(j,:),  'Crimes_2024.csv', 'WriteMode', 'append', 'WriteVariableNames', false);
    end
end
fclose('all');
end