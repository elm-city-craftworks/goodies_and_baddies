require 'ray'

Ray.game "Test" do
  register { add_hook :quit, method(:exit!) }

  scene :square do
    @rect = Ray::Polygon.rectangle([-10, -10, 20, 20], Ray::Color.red)
    @rect.pos = [200,200]

    always do
      @rect.pos += [-2, 0] if holding?(:left)
      @rect.pos += [2, 0] if holding?(:right)
      @rect.pos += [0, -2] if holding?(:up)
      @rect.pos += [0, 2] if holding?(:down)
    end

    render do |win|
      win.draw @rect
    end
  end

  scenes << :square
end
