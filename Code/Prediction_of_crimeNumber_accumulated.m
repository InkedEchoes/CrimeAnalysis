fd = fopen('Crimes_2024.csv', 'r');
original_data_2024 = readtable('Crimes_2024.csv', 'Delimiter', ',');
fclose(fd);

fd = fopen('Crimes_2023.csv', 'r');
original_data_2023 = readtable('Crimes_2023.csv', 'Delimiter', ',');
fclose(fd);

num_2023 = size(original_data_2023, 1); % 
num_2024 = size(original_data_2024, 1); % 
crimes_count_2023 = zeros(1, 12); 
crimes_count_2024 = zeros(1, 12); 
% calculate the crime cases of the first four month of 2023
for j = 1:num_2023
    current_date = original_data_2023{j, 3}; 
    current_month = month(current_date); 
    col = current_month;
    crimes_count_2023(1, col) = crimes_count_2023(1, col) + 1;
end

% calculate the crime cases of the first four month of 2024
for j = 1:num_2024
    current_date = original_data_2024{j, 3}; % extract the date
    current_month = month(current_date); % extract the month
    col = current_month;
    if col <= 4 
        crimes_count_2024(1, col) = crimes_count_2024(1, col) + 1;
    end
end

% calculate the crime cases

for i = 5:12
    crimes_count_2024(1, i) = crimes_count_2024(1, i-1) + crimes_count_2023(1, i) - crimes_count_2023(1, i-1);
end

crimes_count_2024_first_four = crimes_count_2024(1:4);
crimes_count_2024_last_eight = crimes_count_2024(5:12);
figure;
months = 1:12;
plot(months, crimes_count_2023, '-o', 'Color', 'b', 'LineWidth', 1, 'MarkerFaceColor', 'black', 'MarkerSize', 8); % 2023年数据
hold on;
plot((1:4), crimes_count_2024_first_four, '--x', 'Color', 'g', 'LineWidth', 1, 'MarkerSize', 8); % 2024年数据
hold on;
plot((5:12), crimes_count_2024_last_eight, '--*', 'Color', 'r', 'LineWidth', 1, 'MarkerSize', 8); % 2024年数据

% set the label 
xlabel('Month', 'FontSize', 14);
xticks(months);
xticklabels({'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'});
ylabel('Accumulated Number of Crimes', 'FontSize', 14);
title('Accumulated Number of Crimes by Month (2023 vs. 2024)', 'FontSize', 16);

% legend
legend('Number Of Crimes In 2023', 'Number Of Crimes In 2024','Number Of Predicted Crimes In 2024', 'FontSize', 6);

% set x-axis
xtickangle(45);
set(gca, 'FontSize', 12);

grid on;
grid minor;  

formatSpec = "Created %s";
tNow = datestr(now);
dim = [.13, 0, .07, .07];
str = {sprintf(formatSpec, tNow)}; 
annotation('textbox', dim, 'String', str, 'FitBoxToText', 'on');

saveas(gcf, 'Predicted_accumulated_crimeNumber_line.jpg');
hold off;
