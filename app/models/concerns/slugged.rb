module Slugged
  extend ActiveSupport::Concern

  included do
    validates :slug, presence: true
    validate :slug_must_be_unique
    validates :slug, format: { with: /\A[a-z0-9\-]+\z/, message: I18n.t('slug_error') }

    before_validation :check_slug
  end

  def check_slug
    self.slug ||= to_s.parameterize
    current_slug = self.slug
    n = 0
    while slug_unavailable?(self.slug)
      n += 1
      self.slug = [current_slug, n].join('-')
    end
  end

  def to_param
    slug
  end

  protected

  def slug_unavailable?(slug)
    self.class.unscoped
              .where(slug: slug)
              .where.not(id: self.id)
              .exists?
  end

  def slug_must_be_unique
    errors.add(:slug, :taken) if slug_unavailable?(slug)
  end
end
