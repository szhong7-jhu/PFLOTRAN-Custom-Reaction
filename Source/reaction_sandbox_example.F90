module Reaction_Sandbox_Example_class
!! Sandbox for whole pyrite system
#include "petsc/finclude/petscsys.h"
  use petscsys

! 1. Change all references to "Example" as desired to rename the module and
!    and subroutines within the module. 

  use Reaction_Sandbox_Base_class
  
  use Global_Aux_module
  use Reactive_Transport_Aux_module
  
  use PFLOTRAN_Constants_module

  implicit none
  
  private
  
! 2. Add module variables here.  Note that one must use the PETSc data types 
!    PetscInt, PetscReal, PetscBool to declare variables of type integer
!    float/real*8, and logical respectively.  E.g.
!
! PetscReal, parameter :: formula_weight_of_water = 18.01534d0
  
  type, public, &
    extends(reaction_sandbox_base_type) :: reaction_sandbox_example_type
! 3. Add variables/arrays associated with new reaction.  
    character(len=MAXWORDLENGTH) :: species_name1 ! Fe+++
    character(len=MAXWORDLENGTH) :: species_name2 ! Fe++
    character(len=MAXWORDLENGTH) :: species_name3 ! SO4++
    character(len=MAXWORDLENGTH) :: species_name4 ! H+
    character(len=MAXWORDLENGTH) :: species_name5 ! DOxygen
    PetscInt :: species_id1
    PetscInt :: species_id2
    PetscInt :: species_id3
    PetscInt :: species_id4
    PetscInt :: species_id5
    PetscReal :: rate_constant1, rate_constant2, rate_constant3, rate_constant4, rate_constant5
    PetscReal :: stoich_exp1
    PetscReal :: stoich_exp2
    PetscReal :: stoich_exp3
    PetscReal :: stoich_exp4
    PetscReal :: stoich_const1
    PetscReal :: stoich_const2
    PetscReal :: stoich_const3
    PetscReal :: stoich_const4
    PetscReal :: stoich_const5
    PetscReal :: stoich_const6
    PetscReal :: stoich_const7
    PetscReal :: stoich_const8
    PetscReal :: stoich_const9
    PetscReal :: stoich_const10
    PetscReal :: stoich_const11
    PetscReal :: stoich_const12
    PetscReal :: stoich_const13
    PetscReal :: stoich_const14
  contains
    procedure, public :: ReadInput => ExampleRead
    procedure, public :: Setup => ExampleSetup
    procedure, public :: Evaluate => ExampleReact
    procedure, public :: Destroy => ExampleDestroy
  end type reaction_sandbox_example_type

  public :: ExampleCreate

contains

! ************************************************************************** !

function ExampleCreate()
  ! 
  ! Allocates example reaction object.
  ! 
  ! Author: John Doe (replace in all subroutine headers with name of developer)
  ! Date: 00/00/00 (replace in all subroutine headers with current date)
  ! 

  implicit none
  
  class(reaction_sandbox_example_type), pointer :: ExampleCreate

! 4. Add code to allocate object and initialized all variables to zero and
!    nullify all pointers. E.g.
  allocate(ExampleCreate)
  ExampleCreate%species_name1 = ''
  ExampleCreate%species_name2 = ''
  ExampleCreate%species_name3 = ''
  ExampleCreate%species_name4 = ''

  ExampleCreate%species_id1 = 0
  ExampleCreate%species_id2 = 0
  ExampleCreate%species_id3 = 0
  ExampleCreate%species_id4 = 0
  ExampleCreate%rate_constant1 = 0.d0
  ExampleCreate%rate_constant2 = 0.d0
  ExampleCreate%rate_constant3 = 0.d0
  ExampleCreate%rate_constant4 = 0.d0
  ExampleCreate%rate_constant5 = 0.d0
  ExampleCreate%stoich_exp1 = 0.d0
  ExampleCreate%stoich_exp2 = 0.d0
  ExampleCreate%stoich_exp3 = 0.d0
  ExampleCreate%stoich_exp4 = 0.d0
  ExampleCreate%stoich_const1 = 0.d0
  ExampleCreate%stoich_const2 = 0.d0
  ExampleCreate%stoich_const3 = 0.d0
  ExampleCreate%stoich_const4 = 0.d0
  ExampleCreate%stoich_const5 = 0.d0
  ExampleCreate%stoich_const6 = 0.d0
  ExampleCreate%stoich_const7 = 0.d0
  ExampleCreate%stoich_const8 = 0.d0
  ExampleCreate%stoich_const9 = 0.d0
  ExampleCreate%stoich_const10 = 0.d0
  ExampleCreate%stoich_const11 = 0.d0
  ExampleCreate%stoich_const12 = 0.d0
  ExampleCreate%stoich_const13 = 0.d0
  ExampleCreate%stoich_const14 = 0.d0

  nullify(ExampleCreate%next)  
      
end function ExampleCreate

! ************************************************************************** !
subroutine ExampleRead(this,input,option)

  use Option_module
  use String_module
  use Input_Aux_module
  
  implicit none
  
  class(reaction_sandbox_example_type) :: this
  type(input_type), pointer :: input
  type(option_type) :: option

  PetscInt :: i
  character(len=MAXWORDLENGTH) :: word
  
  do 
    call InputReadPflotranString(input,option)
    if (InputError(input)) exit
    if (InputCheckExit(input,option)) exit

    call InputReadWord(input,option,word,PETSC_TRUE)
    call InputErrorMsg(input,option,'keyword', &
                       'CHEMISTRY,REACTION_SANDBOX,EXAMPLE')
    call StringToUpper(word)   

    select case(trim(word))

! Nothing to add given the reaction is hardwired.  But note that the empty
! block for the sandbox reaction AMD_RPYRITE_CSA must still exist in the input file, 
! i.e.

! CHEMISTRY
!   ...
!   REACTION_SANDBOX
!     AMD_RPYRITE_CSA
!     /
!   /
!   ...
! END
 
! 5. Add case statement for reading variables.  E.g.
!     case('AMD_RPYRITE_CSA_INTEGER')
! 6. Read the variable
!       call InputReadInt(input,option,this%amd_rpyrite_csa_integer)  
! 7. Inform the user of any errors if not read correctly.
!       call InputErrorMsg(input,option,'amd_rpyrite_csa_integer', & 
!                          'CHEMISTRY,REACTION_SANDBOX,AMD_RPYRITE_CSA') 
! 8. Repeat for other variables
!     case('AMD_RPYRITE_CSA_INTEGER_Array')
!       allocate(this%amd_rpyrite_csa_integer_array(3))
!       this%amd_rpyrite_csa_integer_array = 0
!       do i = 1, 3
!         call InputReadInt(input,option,this%amd_rpyrite_csa_integer_array(i))  
!         call InputErrorMsg(input,option,'amd_rpyrite_csa_integer_array', & 
!                            'CHEMISTRY,REACTION_SANDBOX,AMD_RPYRITE_CSA') 
!       
!       enddo

      case default
        option%io_buffer = 'CHEMISTRY,REACTION_SANDBOX,EXAMPLE keyword: ' // &
          trim(word) // ' not recognized.'
        call printErrMsg(option)
    end select
  enddo
  
end subroutine ExampleRead

! ************************************************************************** !

subroutine ExampleSetup(this,reaction,option)
  ! 
  ! Sets up the example reaction either with parameters either
  ! read from the input deck or hardwired.
  ! 
  ! Author: John Doe
  ! Date: 00/00/00
  ! 

  use Reaction_Aux_module, only : reaction_rt_type, GetPrimarySpeciesIDFromName
  use Option_module
  use Reaction_Immobile_Aux_module, only : GetImmobileSpeciesIDFromName

  implicit none
  
  class(reaction_sandbox_example_type) :: this
  class(reaction_rt_type) :: reaction
  type(option_type) :: option

! 9. Add code to initialize 
!this%species_id2 = &
  !GetImmobileSpeciesIDFromName(this%species_name2,reaction%immobile,option)
    this%species_name1 = 'Fe+++'
    this%species_name2 = 'Fe++'
    this%species_name3 = 'SO4--'
    this%species_name4 = 'H+'
    this%species_name5 = 'DOxygen'
    this%species_id1 = &
      GetPrimarySpeciesIDFromName(this%species_name1,reaction,option)
    this%species_id2 = &
      GetPrimarySpeciesIDFromName(this%species_name2,reaction,option)
    this%species_id3 = &
      GetPrimarySpeciesIDFromName(this%species_name3,reaction,option)
    this%species_id4 = &
      GetPrimarySpeciesIDFromName(this%species_name4,reaction,option)
    this%species_id5 = &
      GetPrimarySpeciesIDFromName(this%species_name5,reaction,option)
    this%rate_constant1 =   1.d-6 !8.5114d-7 k = 10^-6.07, Fe+++ as oxidant (r2a)  for long time  5.d-8
    this%rate_constant2 =   1.d-7 !6.4565d-9 k = 10^-8.19, DOxygen as oxidant (r1a) 5.d-9
    this%rate_constant3 =   2.d-7 ! k1 = 1.3d-6, for Fe++ to Fe+++             5.d-8
    this%rate_constant4 =   5.d-15 ! k2 = 4.8d-14, for Fe++ to Fe+++ k2*kw^2   1.d-16
    this%rate_constant5 =   1.d-6 !Goethite precipitation
    this%stoich_exp1 = 0.93d0  ! [Fe+++] exponent
    this%stoich_exp2 = -0.4d0  ! [Fe++] exponent
    this%stoich_exp3 =  0.5d0  ! [DOxygen] exponent
    this%stoich_exp4 = -0.11d0 ! [H+] exponent
  ! r2a coefficients Fe+++ as oxidant
    this%stoich_const1 = -14.d0 ! Fe+++
    this%stoich_const2 = 15.d0  ! Fe++
    this%stoich_const3 = 2.d0   ! SO4
    this%stoich_const4 = 16.d0  ! H+
  ! r1a coefficients DOxygen as oxidant
    this%stoich_const5 = -3.5d0 ! DOxygen
    this%stoich_const6 =  2.0d0 ! H+
    this%stoich_const7 =  1.0d0 ! Fe++
    this%stoich_const8 =  2.0d0 ! SO4
  ! r3a coefficients Fe++ to Fe+++
    this%stoich_const9 = -1.0d0 ! Fe++
    this%stoich_const10 = 1.0d0 ! Fe+++
    this%stoich_const11 = -0.25d0 ! DOxygen
    this%stoich_const12 = -1.0d0 ! H+
  ! r4a coefficients Goethite
    this%stoich_const13 = -1.0d0 ! Fe+++
    this%stoich_const14 = 3.0d0 ! H+
end subroutine ExampleSetup

! ************************************************************************** !

subroutine ExampleReact(this,Residual,Jacobian,compute_derivative, &
                         rt_auxvar,global_auxvar,material_auxvar,reaction, &
                         option)
  ! 
  ! Evaluates reaction storing residual and/or Jacobian
  ! 
  ! Author: John Doe
  ! Date: 00/00/00
  ! 

  use Option_module
  use Reaction_Aux_module
  use Material_Aux_class
  
  implicit none
  
  class(reaction_sandbox_example_type) :: this  
  type(option_type) :: option
  class(reaction_rt_type) :: reaction
  PetscBool :: compute_derivative
  ! the following arrays must be declared after reaction
  PetscReal :: Residual(reaction%ncomp)
  PetscReal :: Jacobian(reaction%ncomp,reaction%ncomp)
  type(reactive_transport_auxvar_type) :: rt_auxvar
  type(global_auxvar_type) :: global_auxvar
  class(material_auxvar_type) :: material_auxvar

  PetscInt, parameter :: iphase = 1
  PetscInt :: imnrl, imnrl2
  PetscReal :: volume                 ! m^3 bulk
  PetscReal :: porosity               ! m^3 pore space / m^3 bulk
  PetscReal :: liquid_saturation      ! m^3 water / m^3 pore space

  PetscReal :: TotFe, oxygen, Hydrogen
  PetscReal :: L_water, r1a, r2a, r3a, r4a, Im_const, rhob, specSA, exposed
  PetscReal :: Rate, RateA, RateB, RateC
  PetscReal :: k, k0, Osat
  PetscReal :: r
  porosity = material_auxvar%porosity
  liquid_saturation = global_auxvar%sat(iphase)
  volume = material_auxvar%volume

  rt_auxvar%mnrl_rate(:) = 0.d0
  L_water = porosity*liquid_saturation*volume*1.d3  ! 1.d3 converts m^3 water -> L water

  imnrl = 1
  imnrl2 = 2



  ! Constants
  rhob       = 4.9d6 ! pyrite bulk density =  4.9g/cm^3, [g_pyrite/m^3]
  specSA     = 5.d-2  ! pyrite spec. SA = 0.05 [m^2/g]
  exposed    = 6.d-2  ! pyrite percent exposed = 6%


  TotFe = rt_auxvar%total(this%species_id1,iphase)
   
  oxygen = rt_auxvar%total(this%species_id5,iphase)

  
  k0 = 0
  Osat = 2.25d-4



  if (rt_auxvar%mnrl_volfrac(imnrl) > 0.002 .and. oxygen > 1.d-6 .and. TotFe > 1.d-14) then
  ! Incorporating reactive surface area:
  ! Im_const = rt_auxvar%mnrl_area(imnrl) ! Use default mineral area

  ! Use custom mineral area (shrinking core)
  ! units: [m^2/m^3]
    Im_const = rt_auxvar%mnrl_volfrac(imnrl)

    ! rate (for Residual):  mol/sec
    ! rate (for Vol. frac): mol/sec/m^3 bulk
  
    ! calculate pyrite oxidation rates 
    ! units: mol/sec/m^2/m^3 bulk
    r2a = this%rate_constant1 * &
        rt_auxvar%total(this%species_id1,iphase)**this%stoich_exp1 * &
        rt_auxvar%total(this%species_id2,iphase)**this%stoich_exp2
  
    r1a = this%rate_constant2 * &
        rt_auxvar%total(this%species_id5,iphase)**this%stoich_exp3 * &
        rt_auxvar%total(this%species_id4,iphase)**this%stoich_exp4
    
    r3a = (this%rate_constant3 + this%rate_constant4/(rt_auxvar%total(this%species_id4,iphase)**2)) * &
        rt_auxvar%total(this%species_id2,iphase) * rt_auxvar%total(this%species_id5,iphase)
    
    r4a = this%rate_constant5 * rt_auxvar%total(this%species_id1,iphase)

    ! store volumetric rate to be used in updating mineral volume fractions
    ! at end of time step, MUST FLIP SIGN
    rt_auxvar%mnrl_rate(imnrl) =  (r1a+r2a) * (-Im_const) ! mol/sec/m^3 bulk  1.d3 *
    rt_auxvar%mnrl_rate(imnrl2) = r4a * (rt_auxvar%mnrl_volfrac(imnrl2)+0.000001) ! mol/sec/m^3 bulk
    ! convert rate from volumetric (mol/sec/m^2/m^3 bulk) to mol/sec
    ! units: mol/sec
    r2a = r2a * material_auxvar%volume * Im_const
    r1a = r1a * material_auxvar%volume * Im_const
    r3a = r3a * material_auxvar%volume * Im_const
    r4a = r4a * material_auxvar%volume * rt_auxvar%mnrl_volfrac(imnrl2)
    ! Alway subtract contribution from residual
  
    ! Residual for Fe+++
    Residual(this%species_id1) = Residual(this%species_id1) - &
      this%stoich_const1 * r2a - this%stoich_const10 * r3a - this%stoich_const13 * r4a
  
    ! Residual for Fe++
    Residual(this%species_id2) = Residual(this%species_id2) - &
      this%stoich_const7 * r1a - this%stoich_const2 * r2a - this%stoich_const9 * r3a
  
    ! Residual for SO4--
    Residual(this%species_id3) = Residual(this%species_id3) - &
      this%stoich_const8 * r1a - this%stoich_const3 * r2a
  
    ! Residual for H+
    Residual(this%species_id4) = Residual(this%species_id4) - &
      this%stoich_const6 * r1a - this%stoich_const4 * r2a - this%stoich_const12 * r3a - this%stoich_const14 * r4a
  
    ! Residual for DOxygen
    Residual(this%species_id5) = Residual(this%species_id5) - this%stoich_const5 * r1a - this%stoich_const11 * r3a
      
                                                ! mol/sec/m^3 bulk
  !r1a = k * & rt_auxvar%total(this%species_id1,iphase)
  !    (* rt_auxvar%pri_molal(this%species_id1))**(0.93) * &
  !    (rt_auxvar%pri_molal(this%species_id2))**(-0.40)* 
  !rt_auxvar%mnrl_rate(imnrl) = r1a * (-Im_const)
  !Rate = r1a * material_auxvar%volume * Im_const
  ! Description of subroutine arguments:

  ! Residual - 1D array storing residual entries in units mol/sec
  ! Jacobian - 2D array storing Jacobian entires in units kg water/sec
  !
  !  Jacobian [kg water/sec] * dc [mol/kg water] = -Res [mol/sec]
  !
  ! compute_derivative - Flag indicating whether analtical derivative should
  !   be calculated.  The user must provide either the analytical derivatives 
  !   or a numerical approximation unless always running with 
  !   NUMERICAL_JACOBIAN_RXN defined in input deck.  If the use of 
  !   NUMERICAL_JACOBIAN_RXN is assumed, the user should provide an error 
  !   message when compute_derivative is true.  E.g.
  !
  !   option%io_buffer = 'NUMERICAL_JACOBIAN_RXN must always be used ' // &
  !                      'due to assumptions in Example'
  !   call PrintErrMsg(option)
  !
  ! rt_auxvar - Object holding chemistry information (e.g. concentrations,
  !   activity coefficients, mineral volume fractions, etc.).  See
  !   reactive_transport_aux.F90.  
  !
  !   Useful variables:
  !     rt_auxvar%total(:,iphase) - total component concentrations 
  !                                 [mol/L water] for phase
  !     rt_auxvar%pri_molal(:) - free ion concentrations [mol/kg water]
  !     rt_auxvar%pri_act_coef(:) - activity coefficients for primary species
  !     rt_auxvar%aqueous%dtotal(:,iphase) - derivative of total component
  !                 concentration with respect to free ion [kg water/L water]
  !
  ! global_auxvar - Object holding information on flow (e.g. saturation,
  !   density, viscosity, temperature, etc)
  !
  !   Useful variables:
  !     global_auxvar%den(iphase) - fluid density [mol/m^3] 
  !     global_auxvar%den_kg(iphase) - fluid density [kg/m^3] 
  !     global_auxvar%sat(iphase) - saturation 
  !     global_auxvar%temp - temperature [C]
  !
  ! porosity - effective porosity of grid cell [m^3 pore/m^3 bulk]                     
  ! volume - volume of grid cell [m^3]
  ! reaction - Provides access to variable describing chemistry.  E.g.
  !   reaction%ncomp - # chemical degrees of freedom (mobile and immobile)
  !   reaction%naqcomp - # chemical degrees of freedom on water
  !   reaction%primary_species_names(:) - names of primary species
  !
  ! option - Provides handle for controlling simulation, catching and
  !          reporting errors.
  
  ! Unit of the residual must be in moles/second
  ! global_auxvar%sat(iphase) = saturation of cell
  ! 1.d3 converts m^3 water -> L water

  ! always subtract contribution from residual
  !Residual(this%species_id1) = Residual(this%species_id1) - &
  !  (-1.d0) * & ! negative stoichiometry
  !  this%rate_constant * &  ! 1/sec
  !  L_water * & ! L water
    ! rt_auxvar%total(this%species_id1,iphase) = species total component 
    !   concentration
  !  rt_auxvar%total(this%species_id1,iphase) ! mol/L water
 
  elseif (rt_auxvar%mnrl_volfrac(imnrl) <= 0.002 .and. oxygen > 1.d-6 .and. TotFe > 1.d-14) then
 
  ! Im_const = rt_auxvar%mnrl_area(imnrl) ! Use default mineral area

  ! Use custom mineral area (shrinking core)
  ! units: [m^2/m^3]
    Im_const = rt_auxvar%mnrl_volfrac(imnrl)

    ! rate (for Residual):  mol/sec
    ! rate (for Vol. frac): mol/sec/m^3 bulk
  
    ! calculate pyrite oxidation rates WR (1994)
    ! units: mol/sec/m^2/m^3 bulk
    r2a = this%rate_constant1 * &
        rt_auxvar%total(this%species_id1,iphase)**this%stoich_exp1 * &
        rt_auxvar%total(this%species_id2,iphase)**this%stoich_exp2
  
    r1a = this%rate_constant2 * &
        rt_auxvar%total(this%species_id5,iphase)**this%stoich_exp3 * &
        rt_auxvar%total(this%species_id4,iphase)**this%stoich_exp4
    
    r3a = (this%rate_constant3 + this%rate_constant4/(rt_auxvar%total(this%species_id4,iphase)**2)) * &
        rt_auxvar%total(this%species_id2,iphase) * rt_auxvar%total(this%species_id5,iphase)
    
    r4a = this%rate_constant5 * rt_auxvar%total(this%species_id1,iphase) 

    ! store volumetric rate to be used in updating mineral volume fractions
    ! at end of time step, MUST FLIP SIGN
    rt_auxvar%mnrl_rate(imnrl) =  (r1a+r2a) * (-Im_const) ! mol/sec/m^3 bulk 1.d3 *
    rt_auxvar%mnrl_rate(imnrl2) = 1.d8 * r4a * (rt_auxvar%mnrl_volfrac(imnrl2)+0.000001) ! mol/sec/m^3 bulk
    ! convert rate from volumetric (mol/sec/m^2/m^3 bulk) to mol/sec
    ! units: mol/sec
    r2a = r2a * material_auxvar%volume * Im_const
    r1a = r1a * material_auxvar%volume * Im_const
    r3a = r3a * material_auxvar%volume * Im_const
    r4a = r4a * material_auxvar%volume * rt_auxvar%mnrl_volfrac(imnrl2) * 1000 !VF*100
    ! Alway subtract contribution from residual
  
    ! Residual for Fe+++
    Residual(this%species_id1) = Residual(this%species_id1) - &
      this%stoich_const1 * r2a - this%stoich_const10 * r3a - this%stoich_const13 * r4a
  
    ! Residual for Fe++
    Residual(this%species_id2) = Residual(this%species_id2) - &
      this%stoich_const7 * r1a - this%stoich_const2 * r2a - this%stoich_const9 * r3a
  
    ! Residual for SO4--
    Residual(this%species_id3) = Residual(this%species_id3) - &
      this%stoich_const8 * r1a - this%stoich_const3 * r2a
  
    ! Residual for H+
    Residual(this%species_id4) = Residual(this%species_id4) - &
      this%stoich_const6 * r1a - this%stoich_const4 * r2a - this%stoich_const12 * r3a - this%stoich_const14 * r4a
  
    ! Residual for DOxygen
    Residual(this%species_id5) = Residual(this%species_id5) - this%stoich_const5 * r1a - this%stoich_const11 * r3a
      
                                                ! mol/sec/m^3 bulk
  !Residual(this%species_id2 + reaction%offset_immobile) = &
  !Residual(this%species_id2 + reaction%offset_immobile) - RateB
  else ! Set mnrl_rate to zero
    rt_auxvar%mnrl_rate(imnrl) = 0.d0
      !r1a = 0   2.d-9  7.d-14  -1.d-10  1.d-13
      !Residual(this%species_id1) = Residual(this%species_id1) - (-1* r1a)
      !Residual(this%species_id2) = Residual(this%species_id2) - ( 1* r1a)
  endif

  !if (compute_derivative) then

! 11. If using an analytical Jacobian, add code for Jacobian evaluation

    ! always add contribution to Jacobian
    ! units = (mol/sec)*(kg water/mol) = kg water/sec
  !  Jacobian(this%species_id1,this%species_id1) = &
  !  Jacobian(this%species_id1,this%species_id1) + &
  !    (-1.d0) * & ! negative stoichiometry
  !    this%rate_constant * & ! 1/sec
  !    L_water * & ! L water
                  ! kg water/L water
      ! rt_auxvar%aqueous%dtotal(this%species_id1,this%species_id1,iphase) = 
      !   derivative of total component concentration with respect to the
      !   free ion concentration of the same species.
  !    rt_auxvar%aqueous%dtotal(this%species_id1,this%species_id1,iphase) 

  !endif
  
end subroutine ExampleReact

! ************************************************************************** !

subroutine ExampleDestroy(this)
  ! 
  ! Destroys allocatable or pointer objects created in this
  ! module
  ! 
  ! Author: John Doe
  ! Date: 00/00/00
  ! 

  implicit none
  
  class(reaction_sandbox_example_type) :: this  

! 12. Add code to deallocate contents of the example object

end subroutine ExampleDestroy

end module Reaction_Sandbox_Example_class
