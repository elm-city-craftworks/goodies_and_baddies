require 'ray'

Ray.game "Test" do
  register { add_hook :quit, method(:exit!) }

  scene :square do
    @rect = Ray::Polygon.rectangle([-10, -10, 20, 20], Ray::Color.red)
    @rect.pos = [200,200]

    always do
      @rect.pos += [-1, 0] if holding?(:left)
      @rect.pos += [1, 0] if holding?(:right)
      @rect.pos += [0, -1] if holding?(:up)
      @rect.pos += [0, 1] if holding?(:down)
    end

    render do |win|
      win.draw @rect
    end
  end

  scenes << :square
end
