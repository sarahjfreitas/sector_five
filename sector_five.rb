require 'gosu'
require 'pry'
require 'require_all'

require_relative 'player'
require_relative 'enemy'
require_relative 'bullet'
require_relative 'explosion'
require_all 'scenes'


class SectorFive < Gosu::Window
  WIDTH = 800
  HEIGHT = 600

  def initialize
    super(WIDTH,HEIGHT)
    self.caption = 'Sector Five'
    @scene = Scene::Start.new(self)
    @scene_key = :start
  end

  def button_down(id)
    @scene.button_down(id)
  end

  def update
    @scene.update
  end

  def draw
    @scene.draw
  end

  def change_scene(next_scene)
    @scene_key = next_scene

    case next_scene
    when :start
      @scene = Scene::Start.new(self)
    when :game
      @scene = Scene::Game.new(self)
    when :end
      @scene = Scene::End.new(self)
    end
  end
end

window = SectorFive.new
window.show
