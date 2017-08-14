class ForumsController < ApplicationController
  def index
    #forum kategorilerini listelemek için dbden tüm verileri çektik
    @forums = Forum.all
    #foruma ait konuları listelemek için dbden tüm verileri çektik
    @topics = Topic.all
  end

  def show
    #dbden forum kategorilerini çektik
    @forums = Forum.all
    #açılan foruma ait id değerine göre tüm verileri değişkene aktardık
    @forum = Forum.find(params[:id])
  end
end
