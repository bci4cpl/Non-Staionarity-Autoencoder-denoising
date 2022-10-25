close all
% clear
% clc;

n_sub = length(AE_list);


counter = 0;
idx = 0;
for i = 1:19
    if length(AE_list{i}) >= 7
        counter = counter + 1;
        idx(counter) = i; 
    end
end

same_mat = reshape(cell2mat(same_list(idx)),7 , [])';
AE_mat = reshape(cell2mat(AE_list(idx)),7 , [])';
diff_mat = reshape(cell2mat(diff_list(idx)),7 , [])';
day_classification = [day_classification_score(idx,1),day_classification_score(idx,2),day_classification_score(idx,3)];


fig1_plot1_data = mean(same_mat);
mean_same = mean(fig1_plot1_data(2:end));
stderr_same = std(fig1_plot1_data(2:end))/sqrt(counter);
fig1_plot2_data = mean(AE_mat);
mean_AE = mean(fig1_plot2_data(2:end));
stderr_AE = std(fig1_plot2_data(2:end))/sqrt(counter);
fig1_plot3_data = mean(diff_mat);
mean_diff = mean(fig1_plot3_data(2:end));
stderr_diff = std(fig1_plot3_data(2:end))/sqrt(counter);

counter2 = 0;
idx_cut = 0;
for i = 1:17
    if mean(same_mat(i, :), 2) >= .75
        counter2 = counter2 + 1;
        idx_cut(counter2) = i; 
    end
end


fig2_plot1_data = mean(same_mat(idx_cut,:));
mean_same_cut = mean(fig2_plot1_data(2:end));
stder_same_cut = std(fig2_plot1_data(2:end))/sqrt(counter2);
fig2_plot2_data = mean(AE_mat(idx_cut,:));
mean_AE_cut = mean(fig2_plot2_data(2:end));
stder_AE_cut = std(fig2_plot2_data(2:end))/sqrt(counter2);
fig2_plot3_data = mean(diff_mat(idx_cut,:));
mean_diff_cut = mean(fig2_plot3_data(2:end));
stder_diff_cut = std(fig2_plot3_data(2:end))/sqrt(counter2);

best = 0;
for i = 1:17
    if mean(AE_mat(i, :), 2) - mean(diff_mat(i, :), 2) > best
        best = mean(AE_mat(i, :), 2) - mean(diff_mat(i, :), 2);
        best_idx = i;
    end
end

fig3_plot1_data = same_mat(2,:);
mean_same_best = mean(fig3_plot1_data(2:end));
std_same_best = std(fig3_plot1_data(2:end));
fig3_plot2_data = AE_mat(2,:);
mean_AE_best = mean(fig3_plot2_data(2:end));
std_AE_best = std(fig3_plot2_data(2:end));
fig3_plot3_data = diff_mat(2,:);
mean_diff_best = mean(fig3_plot3_data(2:end));
std_diff_best = std(fig3_plot3_data(2:end));

days = 0:6;


X = categorical({'Original' , 'Reconstructed' ,'Residuals'});
X = reordercats(X,{'Original', 'Reconstructed','Residuals' });
fig4_ba1_data = mean(day_classification);
fig4_std = std(day_classification)./sqrt(length(day_classification));

[~,p_val_org_rec] = ttest2(day_classification(:,1),day_classification(:,2));
[~,p_val_res_rec] = ttest2(day_classification(:,3),day_classification(:,2));
[~,p_val_org_res] = ttest2(day_classification(:,1),day_classification(:,3));





figure('Units', 'centimeters', 'Position', [0 ,0 ,17.5 ,18.2])
set(gcf,'Color','w')



hA = subplot(4,3,[1,2,4,5]);
hA.Position = [0.05,0.54,0.54,0.44];
hold on
set(gca,'fontname','times', 'fontsize', 8)
title('A)','FontSize', 10)
set(get(gca,'title'),'Position',[0.3 0.99 1.00011])
l1 = plot(days, fig1_plot1_data, 'color', [0.3660 0.3940 0.9880], 'LineWidth',2);
yline(mean_same, '--', 'color', [0.3660 0.3940 0.9880], 'LineWidth',2)

l2 = plot(days, fig1_plot2_data, 'color', [0.3660 0.8940 0.3880], 'LineWidth',2);
yline(mean_AE, '--', 'color', [0.3660 0.8940 0.3880], 'LineWidth',2)

l3 = plot(days, fig1_plot3_data, 'color', [0.9660 0.2940 0.1880], 'LineWidth',2);
yline(mean_diff, '--', 'color', [0.9660 0.2940 0.1880], 'LineWidth',2)


xlim([0,6])
ylim([.4,1])
xlabel('Session number')
ylabel('Accuracy')

% hlg = legend('WS', 'AE+CS', 'CS');
hlg = legend([l1 , l3, l2], 'Within session', 'Cross session', 'AE+Cross session');


hB = subplot(4,3,[7,10]);
hold on
set(gca,'fontname','times', 'fontsize', 8);
hB.Position = [0.05,0.08,0.23,0.4];
title('C)','FontSize', 10)
set(get(gca,'title'),'Position',[0.8 .99 1.00011])

plot(days, fig2_plot1_data, 'color', [0.3660 0.3940 0.9880], 'LineWidth',1.5 )
yline(mean_same_cut, '--', 'color', [0.3660 0.3940 0.9880], 'LineWidth',2)

plot(days, fig2_plot2_data, 'color', [0.3660 0.8940 0.3880], 'LineWidth',1.5)
yline(mean_AE_cut, '--', 'color', [0.3660 0.8940 0.3880], 'LineWidth',2)

plot(days, fig2_plot3_data, 'color', [0.9660 0.2940 0.1880], 'LineWidth',1.5)
yline(mean_diff_cut, '--', 'color', [0.9660 0.2940 0.1880], 'LineWidth',2)

xlim([0,6])
ylim([.4,1])
xlabel('Session number')
ylabel('Accuracy')

hC = subplot(4,3,[8,11]);
hC.Position = [0.37,0.08,0.23,0.4];
hold on
set(gca,'fontname','times', 'fontsize', 8)
title('D)','FontSize', 10)
set(get(gca,'title'),'Position',[0.8 0.99 1.00011])
plot(days, fig3_plot1_data, 'color', [0.3660 0.3940 0.9880], 'LineWidth',1.5)
yline(mean_same_best, '--', 'color', [0.3660 0.3940 0.9880], 'LineWidth',2)

plot(days, fig3_plot2_data, 'color', [0.3660 0.8940 0.3880],'LineWidth',1.5)
yline(mean_AE_best, '--', 'color', [0.3660 0.8940 0.3880], 'LineWidth',2)

plot(days, fig3_plot3_data, 'color', [0.9660 0.2940 0.1880],'LineWidth',1.5)
yline(mean_diff_best, '--', 'color', [0.9660 0.2940 0.1880], 'LineWidth',2)

xlim([0,6])
ylim([.4,1])
xlabel('Session number')
ylabel('Accuracy')


hD = subplot(4,3,[3,6]);
hD.Position = [0.65,0.54,0.35,0.44];
hold on
set(gca,'fontname','times', 'fontsize', 8)
title('B)','FontSize', 10)
set(get(gca,'title'),'Position',[0.3 0.99 1.00011])

hBar = bar(X, fig4_ba1_data);
errorbar(X,fig4_ba1_data, fig4_std,'k' ,"LineStyle","none", 'LineWidth',1)

plot(X(1:2), [0.88,0.88], '-k', 'LineWidth',2)
scatter([1.35,1.5,1.65], [0.9,0.9,0.9], '*k')
scatter([1,2], [0.88,0.88], '|k')

plot(X(1:3), [0.93,0.93,0.93], '-k', 'LineWidth',2)
text(1.9, 0.955, 'ns')
scatter([1,3], [0.93,0.93], '|k')

plot(X(2:3), [0.83,0.83], '-k', 'LineWidth',2)
scatter([2.35,2.5,2.65], [0.85,0.85,0.85], '*k')
scatter([2,3], [0.83,0.83], '|k')

ylim([.3,1])
ylabel('Accuracy')
hlg.Position = [0.6964 0.09 0.2553 0.1161];
hlg.FontSize = 8;
hlg.FontName = 'times';

