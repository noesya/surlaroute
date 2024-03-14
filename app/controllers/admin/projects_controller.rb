class Admin::ProjectsController < Admin::ApplicationController
  load_and_authorize_resource find_by: :slug

  include Admin::ResourceWithStructure

  def index
    @projects = @projects.autofilter(params[:filters]).ordered.page(params[:page])
    breadcrumb
  end

  def show
    breadcrumb
  end

  def new
    breadcrumb
  end

  def edit
    breadcrumb
    add_breadcrumb t('edit')
  end

  def create
    @project.published_by = current_user if cannot?(:publish, @project)
    if @project.save
      redirect_to [:admin, @project], notice: t('admin.successfully_created_html', model: @project.to_s)
    else
      breadcrumb
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @project.update(project_params)
      redirect_to [:admin, @project], notice: t('admin.successfully_updated_html', model: @project.to_s)
    else
      breadcrumb
      add_breadcrumb t('edit')
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @project.destroy
    redirect_to admin_projects_url, notice: t('admin.successfully_destroyed_html', model: @project.to_s)
  end

  protected

  def breadcrumb
    super
    add_breadcrumb Project.model_name.human(count: 2), admin_projects_path
    breadcrumb_for @project
  end

  def project_params
    params.require(:project)
          .permit(
            :name, :slug, :description,
            :image, :image_delete, :image_infos, :image_alt, :image_credit,
            :published, :published_by_id,
            :step0_sustainable_program, :step0_sustainable_program_text, :step0_low_tech,
            :step0_low_tech_text, :step0_ecodesign_time, :step0_ecodesign_time_text,
            :step1_reusable_materials, :step1_reusable_materials_text, :step1_recycled_materials,
            :step1_recycled_materials_text, :step1_local_materials, :step1_local_materials_text,
            :step2_dismountable, :step2_dismountable_text, :step2_components_reduced_amount,
            :step2_components_reduced_amount_text, :step2_renewable_energy, :step2_renewable_energy_text,
            :step3_matter_reduced_amount, :step3_matter_reduced_amount_text,
            :step4_artists_travel_optimization, :step4_artists_travel_optimization_text, :step4_transport_sharing,
            :step4_transport_sharing_text, :step4_separate_packaging, :step4_separate_packaging_text,
            :step5_energy_efficient, :step5_energy_efficient_text, :step5_water_efficient,
            :step5_water_efficient_text, :step5_low_power_consumption, :step5_low_power_consumption_text,
            :step5_zero_waste, :step5_zero_waste_text, :step5_public_awareness,
            :step5_public_awareness_text, :step5_public_area_sorting, :step5_public_area_sorting_text,
            :step6_extended_lifetime, :step6_extended_lifetime_text,
            :step7_disassembly_five_stream_sorting, :step7_disassembly_five_stream_sorting_text, :step7_composted_materials,
            :step7_composted_materials_text, :step7_closed_loop_recycling, :step7_closed_loop_recycling_text,
            actor_ids: [], material_ids: [], technic_ids: [],
            region_ids: [],
            answers_attributes: [:id, :criterion_id, :value, :text],
            structure_values_attributes: structure_values_permitted_attributes
          )
  end
end
