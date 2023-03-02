using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

namespace WebApplication1.Models;

public partial class MaindataContext : DbContext
{
    public MaindataContext()
    {
    }

    public MaindataContext(DbContextOptions<MaindataContext> options)
        : base(options)
    {
    }

    public virtual DbSet<Address> Addresses { get; set; }

    public virtual DbSet<AddressType> AddressTypes { get; set; }

    public virtual DbSet<AggregatorSpecialist> AggregatorSpecialists { get; set; }

    public virtual DbSet<AggregatorSpecialistConnectorRequest> AggregatorSpecialistConnectorRequests { get; set; }

    public virtual DbSet<ConnectionRequest> ConnectionRequests { get; set; }

    public virtual DbSet<Customer> Customers { get; set; }

    public virtual DbSet<Demo> Demos { get; set; }

    public virtual DbSet<Organization> Organizations { get; set; }

    public virtual DbSet<ServiceDetail> ServiceDetails { get; set; }

    public virtual DbSet<ServiceRequest> ServiceRequests { get; set; }

    public virtual DbSet<ServiceRequestDetai> ServiceRequestDetais { get; set; }

    public virtual DbSet<TypeOfService> TypeOfServices { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see http://go.microsoft.com/fwlink/?LinkId=723263.
        => optionsBuilder.UseSqlite("Data Source=bin\\Debug\\net6.0\\maindata.db");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Address>(entity =>
        {
            entity.ToTable("address");

            entity.Property(e => e.AddressId).HasColumnName("address_id");
            entity.Property(e => e.AddInfo).HasColumnName("add_info");
            entity.Property(e => e.AddressTypeId).HasColumnName("address_type_id");
            entity.Property(e => e.CityName).HasColumnName("city_name");
            entity.Property(e => e.HouseNumber).HasColumnName("house_number");
            entity.Property(e => e.OrganizationId).HasColumnName("organization_id");
            entity.Property(e => e.StreetName).HasColumnName("street_name");
            entity.Property(e => e.SubjectName).HasColumnName("subject_name");

            entity.HasOne(d => d.AddressType).WithMany(p => p.Addresses)
                .HasForeignKey(d => d.AddressTypeId)
                .OnDelete(DeleteBehavior.ClientSetNull);

            entity.HasOne(d => d.Organization).WithMany(p => p.Addresses)
                .HasForeignKey(d => d.OrganizationId)
                .OnDelete(DeleteBehavior.ClientSetNull);
        });

        modelBuilder.Entity<AddressType>(entity =>
        {
            entity.ToTable("Address_type");

            entity.Property(e => e.AddressTypeId).HasColumnName("address_type_id");
            entity.Property(e => e.AddressTypeName).HasColumnName("address_type_name");
        });

        modelBuilder.Entity<AggregatorSpecialist>(entity =>
        {
            entity.HasKey(e => e.AggregatorSpecialistsId);

            entity.ToTable("Aggregator_specialist");

            entity.Property(e => e.AggregatorSpecialistsId).HasColumnName("aggregator_specialists_id");
            entity.Property(e => e.AggregatorSpecialistName).HasColumnName("aggregator_specialist_name");
            entity.Property(e => e.AggregatorSpecialistSurname).HasColumnName("aggregator_specialist_surname");
            entity.Property(e => e.AggregatorSpecialistsDepartment).HasColumnName("aggregator_specialists_department");
            entity.Property(e => e.AggregatorSpecialistsPhoneNumber).HasColumnName("aggregator_specialists_phone_number");
            entity.Property(e => e.AggregatorSpecialistsPosition).HasColumnName("aggregator_specialists_position");
        });

        modelBuilder.Entity<AggregatorSpecialistConnectorRequest>(entity =>
        {
            entity.ToTable("Aggregator_specialist_connector_request");

            entity.Property(e => e.AggregatorSpecialistConnectorRequestId).HasColumnName("Aggregator_specialist_connector_request_id");
            entity.Property(e => e.AggregatorSpecialistsId).HasColumnName("aggregator_specialists_id");
            entity.Property(e => e.ConnectionRequestId).HasColumnName("connection_request_id");

            entity.HasOne(d => d.AggregatorSpecialists).WithMany(p => p.AggregatorSpecialistConnectorRequests)
                .HasForeignKey(d => d.AggregatorSpecialistsId)
                .OnDelete(DeleteBehavior.ClientSetNull);

            entity.HasOne(d => d.ConnectionRequest).WithMany(p => p.AggregatorSpecialistConnectorRequests)
                .HasForeignKey(d => d.ConnectionRequestId)
                .OnDelete(DeleteBehavior.ClientSetNull);
        });

        modelBuilder.Entity<ConnectionRequest>(entity =>
        {
            entity.ToTable("Connection_request");

            entity.Property(e => e.ConnectionRequestId).HasColumnName("connection_request_id");
            entity.Property(e => e.DateBegin).HasColumnName("date_begin");
            entity.Property(e => e.OrganizationId).HasColumnName("organization_id");
            entity.Property(e => e.RegNumber).HasColumnName("reg_number");
            entity.Property(e => e.Status).HasColumnName("status");

            entity.HasOne(d => d.Organization).WithMany(p => p.ConnectionRequests)
                .HasForeignKey(d => d.OrganizationId)
                .OnDelete(DeleteBehavior.ClientSetNull);
        });

        modelBuilder.Entity<Customer>(entity =>
        {
            entity.ToTable("Customer");

            entity.Property(e => e.CustomerId).HasColumnName("customer_id");
            entity.Property(e => e.CustomerName).HasColumnName("customer_name");
            entity.Property(e => e.CustomerPhoneNumber).HasColumnName("customer_phone_number");
            entity.Property(e => e.CustomerSurname).HasColumnName("customer_surname");
        });

        modelBuilder.Entity<Demo>(entity =>
        {
            entity.ToTable("demo");

            entity.Property(e => e.Id).HasColumnName("ID");
        });

        modelBuilder.Entity<Organization>(entity =>
        {
            entity.ToTable("Organization");

            entity.Property(e => e.OrganizationId).HasColumnName("organization_id");
            entity.Property(e => e.AddInfo).HasColumnName("add_info");
            entity.Property(e => e.Inn).HasColumnName("inn");
            entity.Property(e => e.Kpp).HasColumnName("kpp");
            entity.Property(e => e.Ogrn).HasColumnName("ogrn");
            entity.Property(e => e.OrganizationFullName).HasColumnName("organization_full_name");
            entity.Property(e => e.OrganizationShortName).HasColumnName("organization_short_name");
            entity.Property(e => e.ResponsiblePersonEmail).HasColumnName("responsible_person_email");
            entity.Property(e => e.ResponsiblePersonName).HasColumnName("responsible_person_name");
            entity.Property(e => e.ResponsiblePersonPhoneNumber).HasColumnName("responsible_person_phone_number");
            entity.Property(e => e.ResponsiblePersonSurname).HasColumnName("responsible_person_surname");
        });

        modelBuilder.Entity<ServiceDetail>(entity =>
        {
            entity.ToTable("Service_detail");

            entity.Property(e => e.ServiceDetailId).HasColumnName("service_detail_id");
            entity.Property(e => e.AddInfo).HasColumnName("add_info");
            entity.Property(e => e.ServiceDetailCode).HasColumnName("service_detail_code");
            entity.Property(e => e.ServiceDetailCost).HasColumnName("service_detail_cost");
            entity.Property(e => e.ServiceDetailDuration).HasColumnName("service_detail_duration");
            entity.Property(e => e.ServiceDetailName).HasColumnName("service_detail_name");
            entity.Property(e => e.TypeId).HasColumnName("type_id");

            entity.HasOne(d => d.Type).WithMany(p => p.ServiceDetails)
                .HasForeignKey(d => d.TypeId)
                .OnDelete(DeleteBehavior.ClientSetNull);
        });

        modelBuilder.Entity<ServiceRequest>(entity =>
        {
            entity.ToTable("Service_request");

            entity.Property(e => e.ServiceRequestId).HasColumnName("service_request_id");
            entity.Property(e => e.CustomerId).HasColumnName("customer_id");
            entity.Property(e => e.DateService).HasColumnName("date_service");
            entity.Property(e => e.OrganizationId).HasColumnName("organization_id");
            entity.Property(e => e.ServiceDetailCost).HasColumnName("service_detail_cost");
            entity.Property(e => e.ServiceDetailDuration).HasColumnName("service_detail_duration");

            entity.HasOne(d => d.Customer).WithMany(p => p.ServiceRequests)
                .HasForeignKey(d => d.CustomerId)
                .OnDelete(DeleteBehavior.ClientSetNull);

            entity.HasOne(d => d.Organization).WithMany(p => p.ServiceRequests)
                .HasForeignKey(d => d.OrganizationId)
                .OnDelete(DeleteBehavior.ClientSetNull);
        });

        modelBuilder.Entity<ServiceRequestDetai>(entity =>
        {
            entity.HasKey(e => e.ServiceRequestDetailId);

            entity.ToTable("Service_request_detai");

            entity.Property(e => e.ServiceRequestDetailId).HasColumnName("service_request_detail_id");
            entity.Property(e => e.ServiceDetailId).HasColumnName("service_detail_id");
            entity.Property(e => e.ServiceRequestId).HasColumnName("service_request_id");

            entity.HasOne(d => d.ServiceDetail).WithMany(p => p.ServiceRequestDetais)
                .HasForeignKey(d => d.ServiceDetailId)
                .OnDelete(DeleteBehavior.ClientSetNull);

            entity.HasOne(d => d.ServiceRequest).WithMany(p => p.ServiceRequestDetais)
                .HasForeignKey(d => d.ServiceRequestId)
                .OnDelete(DeleteBehavior.ClientSetNull);
        });

        modelBuilder.Entity<TypeOfService>(entity =>
        {
            entity.HasKey(e => e.TypeId);

            entity.ToTable("Type_of_service");

            entity.Property(e => e.TypeId).HasColumnName("type_id");
            entity.Property(e => e.TypeCode).HasColumnName("type_code");
            entity.Property(e => e.TypeName).HasColumnName("type_name");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
