function line_handels = plotPower(mean_power, std_dev, f, line_color)
%MATLAB R2019b
%
%This function will plot mean power with shaded area of the std around the
%mean.
%
%line_handels - the handels of the mean line, in order to show him in
%legend
%
%----------------------------------------------------------------------------
curve1 = mean_power + std_dev;
curve2 = mean_power - std_dev;
line_handels = plot(f , mean_power,'LineWidth' , 2, 'color' ,line_color);
x2 = [f, fliplr(f)];
inBetween = [curve1, fliplr(curve2)];
%Plot the filled std
hold on
fill(x2, inBetween, line_color, 'LineStyle','none');
alpha(0.3) %Opacity