class PrototypesController < ApplicationController
   before_action :authenticate_user!,except: [:index]
   before_action :set_prototype, only: [:edit, :show]
   before_action :move_to_index, except: [:index, :show ]

   def index
     query = "SELECT * FROM prototypes"
      @prototypes = Prototype.find_by_sql(query)
   end

  def new
    @prototype = Prototype.new
    if @prototype.save
      redirect_to root_path
    end
    
  end

   def create
     
    @prototype = Prototype.new(prototype_params)
    
    if @prototype.save
      redirect_to root_path
    else
      
      render:new
    end
   end

   def destroy
      prototype = Prototype.find(params[:id])
      prototype.destroy
      redirect_to root_path
    end

   def edit
    @prototype = Prototype.find(params[:id])
    unless @prototype.user_id == current_user.id
      redirect_to root_path
    end
   end

   def update
    @prototype = Prototype.find(params[:id])
    @prototype.update(prototype_params)
    if @prototype.save
      redirect_to prototype_path(params[:id])
    else
      
      render:edit
    end
  end

   def show
      @comment = Comment.new
      @comments = @prototype.comments.includes(:user)
      
      
   end







   private
 def prototype_params
   params.require(:prototype).permit(:name,:image,:text,:title,:catch_copy,:concept).merge(user_id: current_user.id)
 end

 def set_prototype
   @prototype = Prototype.find(params[:id])
 end
 
   def move_to_index
  unless user_signed_in?
    redirect_to action: :index
  end


 end
end 

  