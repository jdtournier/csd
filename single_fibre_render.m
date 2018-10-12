L=4;
a = pi/2;

clf
hold on
for x=-1.5:1:1.5
  for r=-1.5:1:1.5
    F = fibre_mesh (L, 0.4, 2, 50);
    %render_fibre (F, [r z -8], [0 0 1], [0 1 0]);
    %if mod(z+0.5,2) ~= 0
    if x > 0
      render_fibre (F, [r x -2], [0 0 1], [0 1 0]);
    else
      render_fibre (F, [-2 x r], [1 0 0], [0 1 0]);
    end
  end
end

hold off
%tensor
daspect([1 1 1])

light('position', [0 1 1]);

