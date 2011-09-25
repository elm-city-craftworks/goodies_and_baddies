# from http://mon-ouie.github.com/projects/ray.html

require 'ray'
Ray.game "Test" do
  register { add_hook :quit, method(:exit!) }

  scene :square do
    @rect = Ray::Polygon.rectangle([-10, -10, 20, 20], Ray::Color.red)
    @rect.pos = [200, 200]

    render do |win|
      win.draw @rect
    end
  end

  scenes << :square
end
