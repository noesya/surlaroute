# TODO delete me, deprecated
module Project::WithBrezetWheel
  extend ActiveSupport::Concern

  def has_brezet_wheel?
    has_brezet_wheel_step0? ||
    has_brezet_wheel_step1? ||
    has_brezet_wheel_step2? ||
    has_brezet_wheel_step3? ||
    has_brezet_wheel_step4? ||
    has_brezet_wheel_step5? ||
    has_brezet_wheel_step6? ||
    has_brezet_wheel_step7?
  end

  def has_brezet_wheel_step0?
    step0_ecodesign_time? ||
    step0_low_tech? ||
    step0_sustainable_program?
  end

  def has_brezet_wheel_step1?
    step1_local_materials? ||
    step1_recycled_materials? ||
    step1_reusable_materials?
  end

  def has_brezet_wheel_step2?
    step2_components_reduced_amount? ||
    step2_dismountable? ||
    step2_renewable_energy?
  end

  def has_brezet_wheel_step3?
    step3_matter_reduced_amount?
  end

  def has_brezet_wheel_step4?
    step4_artists_travel_optimization? ||
    step4_separate_packaging? ||
    step4_transport_sharing?
  end

  def has_brezet_wheel_step5?
    step5_energy_efficient? ||
    step5_low_power_consumption? ||
    step5_public_area_sorting? ||
    step5_public_awareness? ||
    step5_water_efficient? ||
    step5_zero_waste?
  end

  def has_brezet_wheel_step6?
    step6_extended_lifetime?
  end

  def has_brezet_wheel_step7?
    step7_closed_loop_recycling? ||
    step7_composted_materials? ||
    step7_disassembly_five_stream_sorting?
  end
end