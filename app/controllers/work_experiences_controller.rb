class WorkExperiencesController < ApplicationController
    before_action :set_work_experience, only: %i[edit update destroy]

    def new
        @work_experience = current_user.work_experiences.new
    end

    def edit; end

    def create 
        @work_experience = current_user.work_experiences.new(work_experience_params)
        if @work_experience.save
            render_turbo_stream(
                'append',
                'work_exeperience_items',
                'work_experiences/work_experience',
                { work_experience: @work_experience }
            )
        else
            render_turbo_stream(
                'replace',
                'remote_modal',
                'shared/turbo_modal',
                { form_partial: 'work_experiences/form', 
                  modal_title: 'Add new experiences' 
                }
            )
        end
    end

    def update
        if @work_experience.update(work_experience_params)
            render_turbo_stream(
                'replace',
                "work_exeperience_item_#{@work_experience.id}",
                'work_experiences/work_experience',
                { work_experience: @work_experience }
            )
        else
            render_turbo_stream(
                'replace',
                'remote_modal',
                'shared/turbo_modal',
                { form_partial: 'work_experiences/form', 
                  modal_title: 'Edit experiences' 
                }
            )
        end
        

    end

    def destroy 
        render_turbo_stream(
            'remove',
            "work_exeperience_item_#{@work_experience.id}",
        )
    end

    private

    def set_work_experience
        @work_experience = current_user.work_experiences.find(params[:id])
    end

    def work_experience_params
        params.require(:work_experience).permit(:start_date, :end_date, :currently_working, :company, :employment_type, :location, :location_type, :description, :user_id, :job_title)
    end
end