require 'ray'

Ray.game "Test" do
  register { add_hook :quit, method(:exit!) }

  scene :square do
    @rect = Ray::Polygon.rectangle([-10, -10, 20, 20], Ray::Color.red)
    @rect.pos = [200,200]

    max_x = window.size.width - 20
    max_y = window.size.height - 20

    @goodies = 20.times.map do 
      x = rand(max_x) + 10
      y = rand(max_y) + 10
      
      g  = Ray::Polygon.rectangle([0,0,10,10])
      g.pos = [x,y]

      g
    end

    always do
      @rect.pos += [-2, 0] if holding?(:left)
      @rect.pos += [2, 0] if holding?(:right)
      @rect.pos += [0, -2] if holding?(:up)
      @rect.pos += [0, 2] if holding?(:down)
    end

    render do |win|
      @goodies.each { |g| win.draw(g) }
      win.draw @rect
    end
  end

  scenes << :square
end
