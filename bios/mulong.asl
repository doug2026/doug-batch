//
// FILENAME.
//      mulong.asi -
//
//      $PATH:      \branches\Users\TH_Jeong\OIL\LG\LGE\000\XnotePlatformPkg\Acpi\AcpiPlatform\AcpiTables\Wmi\mulong.asi
//
// FUNCTIONAL DESCRIPTION.
//      This include file defines the definitions used by debugging
//      instrumentation in this driver.
//
//      This file contains definitions for DPRINTF_class, DEBUG_class,
//      and ASSERT_class macros, in order to standardize instrumentation.
//
// MODIFICATION HISTORY.
//      $REVISION:  27084               04-28-2017      04:35:28 PM
//      $REPORT:    Feature
//      $DETAILS:   Initialize ACPI NVS data from CMOS variables by
//                  XnoteBoardDxeSmmLib
//
//      $REVISION:  27040               04/27/2017      05:49:03 PM
//      $REPORT:    Feature
//      $DETAILS:   PTP (Precision Touch Pad) support.
//
//      $REVISION:  24771               02/27/2017      11:06:49 PM
//      $REPORT:    Feature
//      $DETAILS:   Applied build configuration for ECO mode cmos location.
//
//      $REVISION:  24700               02/27/2017      02:49:22 AM
//      $REPORT:    Cosmetic
//      $DETAILS:   Changed NVS field names as LG defined.
//
//      $REVISION:  24657               02/24/2017      11:05:29 AM
//      $REPORT:    Component
//      $DETAILS:   Initial checkin ACPI implementations
//
// NOTICE.
//      Copyright (C) 2016-2017 Phoenix Technologies Ltd.  All Rights Reserved.
//

/*
[]###########################################################################
        LG XNOTE Projects

       Copyright (c) 2002-2014 LG Electronics Inc.
        This program contains proprietary and confidential information. All
        rights reserved except as may be permitted by prior written consent.

[]###########################################################################*/

#include <XnoteBoardInfo.h>       // LGEMOD:ADD
#include <Project.h>              // LGEMOD:ADD [DGK230113A]

External (\_SB.PC00.PEG0.PEGP.GTTV, IntObj)
External (\_SB.NPCF.DBAC, IntObj)
#if OPTION_XNOTE_AUTO_COOLING_SUPPORT // LGEMOD:BEGIN [DGK230113A] - Support Auto Cooling Mode
External (\_SB.PC00.LPCB.LGEC.TFN2.MODE)
External (\_SB.PC00.LPCB.LGEC.FTMS, FieldUnitObj)
#endif  // LGEMOD:END

#if OPTION_BUILD_17X90R
External (\_SB.PC00.LPCB.LGEC._QA3, MethodObj)   // LGEMOD - Support PEN connection status
External (WoTControlGPIO, FieldUnitObj)
#endif

OperationRegion (XTRP, SystemIO, 0xB2, 2)
  Field (XTRP, ByteAcc, NoLock, Preserve)
  {
    XTR0, 8,
    XTR1, 8,
  }

Method(Method_ULong, 3, Serialized)
{
  Store( Arg0, InstanceNumber)
  Store( Arg1, MethodId)
  Store( Arg2, ulValue)

  If(LGreaterEqual(InstanceNumber, 0x100))
  {
    Store(Buffer(){0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00}, Local1)
    CreateDwordField(Local1, 0, ReturnValue)
    CreateDwordField(Local1, 4, StatusValue)
    Store(0x00000000, ReturnValue)
    Store(StatusInstanceNotFound, StatusValue)

    //
    // 0x0400 : Backlit keyboard.
    //
    If (LEqual(InstanceNumber, 0x0400))
    {
      Store(StatusCommandNotSupport, StatusValue)
      If (CondRefOf(IsBacklitSupported)) {
      	If(LEqual(IsBacklitSupported(),0))
      	{
          Return(Local1)
      	}

        If (LEqual(MethodId, FWI_CMD_READ)){
          Store(0, Local0)
          If (CondRefOf(ReadBacklit)) 
          {
            Store(ReadBacklit(), Local0)
          }
          Store(Local0, ReturnValue)
          Store(0, StatusValue)
          Return(Local1)
        } ElseIf (LEqual(MethodId , FWI_CMD_WRITE)){
          And(ulValue,0xffffffff,Local0)
          If (CondRefOf(WriteBacklit))
          {
            WriteBacklit(Local0)
          }		    
          Store(0, StatusValue)
          Store(0, ReturnValue)
          Return(Local1)
        }
      }
      Return (Local1)
    } // end of 0x0400

    //
    // 0x0401 : Daylight Saving.
          //
    If (LEqual(InstanceNumber, 0x0401))
    {
      Store(StatusCommandNotSupport, StatusValue)
      If (CondRefOf(IsDaylightSavingSupported)) {
        If(LEqual(IsDaylightSavingSupported(),0))
        {
          Return(Local1)
        }

        If (LEqual(MethodId, FWI_CMD_READ)){
          Store(0, Local0)
          If (CondRefOf(ReadDaylightSaving))
          {
             Store(ReadDaylightSaving(), Local0)
          }
          Store(Local0, ReturnValue)
          Store(0, StatusValue)
          Return(Local1)
        } ElseIf (LEqual(MethodId , FWI_CMD_WRITE)){
          And(ulValue,0xffffffff,Local0)
          If (CondRefOf(WriteDaylightSaving))
          {
             WriteDaylightSaving(Local0)
          }       
          Store(0, StatusValue)
          Store(0, ReturnValue)
          Return(Local1)
        }
      }
      Return (Local1)
    } // end of 0x0401



    //
    // 0x404 : New Touchpad control
    //
    If (LEqual(InstanceNumber, 0x404))
    {
      Store(StatusCommandNotSupport, StatusValue)
      If (CondRefOf(IsNewTouchpadControlSupported)) {
        If(LEqual(IsNewTouchpadControlSupported(),0))
        {
          Return(Local1)
        }

        If (LEqual(MethodId, FWI_CMD_READ)){
          Store(0, Local0)
          If (CondRefOf(ReadNewTouchpadControl))
          {
             Store(ReadNewTouchpadControl(), Local0)
          }
          Store(Local0, ReturnValue)
          Store(0, StatusValue)
          Return(Local1)
        } ElseIf (LEqual(MethodId , FWI_CMD_WRITE)){
          And(ulValue,0xffffffff,Local0)
          If (CondRefOf(WriteNewTouchpadControl))
          {
             WriteNewTouchpadControl(Local0)
          }       
          Store(0, StatusValue)
          Store(0, ReturnValue)
          Return(Local1)
        }
      }
      Return (Local1)
    } // end of 0x0404


    //
    // 0x405 : System Performance Control
    //
    If (LEqual(InstanceNumber, 0x405))
    {
      Store(StatusCommandNotSupport, StatusValue)
      If (CondRefOf(IsSystemPerformanceControlSupported)) {
        If(LEqual(IsSystemPerformanceControlSupported(),0))
        {
          Return(Local1)
        }

        If (LEqual(MethodId, FWI_CMD_READ)){
          Store(0, Local0)
          If (CondRefOf(ReadSystemPerformanceControl))
          {
             Store(ReadSystemPerformanceControl(), Local0)
          }
          Store(Local0, ReturnValue)
          Store(0, StatusValue)
          Return(Local1)
        } ElseIf (LEqual(MethodId , FWI_CMD_WRITE)){
          And(ulValue,0xffffffff,Local0)
          If (CondRefOf(WriteSystemPerformanceControl))
          {
             WriteSystemPerformanceControl(Local0)
          }       
          Store(0, StatusValue)
          Store(0, ReturnValue)
          Return(Local1)
        }
      }
      Return (Local1)
    } // end of 0x0405


    //
    // 0x406 : ALS Exposure control
    //
    If (LEqual(InstanceNumber, 0x406))
    {
      Store(StatusCommandNotSupport, StatusValue)
      If (CondRefOf(IsAlsExposureControlSupported)) {
        If(LEqual(IsAlsExposureControlSupported(),0))
        {
          Return(Local1)
        }

        If (LEqual(MethodId, FWI_CMD_READ)){
          Store(0, Local0)
          If (CondRefOf(ReadAlsExposureControl))
          {
             Store(ReadAlsExposureControl(), Local0)
          }
          Store(Local0, ReturnValue)
          Store(0, StatusValue)
          Return(Local1)
        } ElseIf (LEqual(MethodId , FWI_CMD_WRITE)){
          And(ulValue,0xffffffff,Local0)
          If (CondRefOf(WriteAlsExposureControl))
          {
             WriteAlsExposureControl(Local0)
          }       
          Store(0, StatusValue)
          Store(0, ReturnValue)
          Return(Local1)
        }
      }
      Return (Local1)
    } // end of 0x0406


    //
    // 0x407 : Fx keys override
    //
    If (LEqual(InstanceNumber, 0x407))
    {
      Store(StatusCommandNotSupport, StatusValue)
      If (CondRefOf(IsFxKeyOverrideSupported)) {
        If(LEqual(IsFxKeyOverrideSupported(),0))
        {
          Return(Local1)
        }

        If (LEqual(MethodId, FWI_CMD_READ)){
          Store(0, Local0)
          If (CondRefOf(ReadFxKeyOverride))
          {
             Store(ReadFxKeyOverride(), Local0)
          }
          Store(Local0, ReturnValue)
          Store(0, StatusValue)
          Return(Local1)
        } ElseIf (LEqual(MethodId , FWI_CMD_WRITE)){
          And(ulValue,0xffffffff,Local0)
          If (CondRefOf(WriteFxKeyOverride))
          {
             WriteFxKeyOverride(Local0)
          }       
          Store(0, StatusValue)
          Store(0, ReturnValue)
          Return(Local1)
        }
      }
      Return (Local1)
    } // end of 0x0407

    //
    // 0x408 : Thunderbolt
    //
    If (LEqual(InstanceNumber, 0x408))
    {
      Store(StatusCommandNotSupport, StatusValue)
      If (CondRefOf(IsThunderboltControlSupported)) {
        If(LEqual(IsThunderboltControlSupported(),0))
        {
          Return(Local1)
        }

        If (LEqual(MethodId, FWI_CMD_READ)){
          Store(0, Local0)
          If (CondRefOf(ReadThunderboltControl))
          {
             Store(ReadThunderboltControl(), Local0)
          }
          Store(Local0, ReturnValue)
          Store(0, StatusValue)
          Return(Local1)
        } ElseIf (LEqual(MethodId , FWI_CMD_WRITE)){
          And(ulValue,0xffffffff,Local0)
          If (CondRefOf(WriteThunderboltControl))
          {
             WriteThunderboltControl(Local0)
          }       
          Store(0, StatusValue)
          Store(0, ReturnValue)
          Return(Local1)
        }
      }
      Return (Local1)
    } // end of 0x0408



    //
    // 0x409 : PTP (Precision Touch Pad) 
    //
    If (LEqual(InstanceNumber, 0x409))
    {
      Store(StatusCommandNotSupport, StatusValue)
      If (CondRefOf(IsPtpControlSupported)) {
        If(LEqual(IsPtpControlSupported(),0))
        {
          Return(Local1)
        }

        If (LEqual(MethodId, FWI_CMD_READ)){
          Store(0, Local0)
          If (CondRefOf(ReadPtpControl))
          {
             Store(ReadPtpControl(), Local0)
          }
          Store(Local0, ReturnValue)
          Store(0, StatusValue)
          Return(Local1)
        } ElseIf (LEqual(MethodId , FWI_CMD_WRITE)){
          And(ulValue,0xffffffff,Local0)
          If (CondRefOf(WritePtpControl))
          {
             WritePtpControl(Local0)
          }       
          Store(0, StatusValue)
          Store(0, ReturnValue)
          Return(Local1)
        }
      }
      Return (Local1)
    } // end of 0x0409

    //
    // 0x40A : Type-C Charging
    //
    If (LEqual(InstanceNumber, 0x40A))
    {
      Store(StatusCommandNotSupport, StatusValue)
      If (CondRefOf(IsTypeCChargingSupported)) {
        If(LEqual(IsTypeCChargingSupported(),0))
        {
          Return(Local1)
        }

        If (LEqual(MethodId, FWI_CMD_READ)){
          Store(0, Local0)
          If (CondRefOf(ReadTypeCCharging))
          {
             Store(ReadTypeCCharging(), Local0)
          }
          Store(Local0, ReturnValue)
          Store(0, StatusValue)
          Return(Local1)
        } ElseIf (LEqual(MethodId , FWI_CMD_WRITE)){
          And(ulValue,0xffffffff,Local0)
          If (CondRefOf(WriteTypeCCharging))
          {
             WriteTypeCCharging(Local0)
          }       
          Store(0, StatusValue)
          Store(0, ReturnValue)
          Return(Local1)
        }
      }
      Return (Local1)
    } // end of 0x40A

    //
    // 0x40B : SAR Sensor Support
    //
    If (LEqual(InstanceNumber, 0x40B))
    {
      Store(StatusCommandNotSupport, StatusValue)
      If (CondRefOf(IsACPCSupported)) {

        If(LEqual(IsACPCSupported(),0))
        {
          Return(Local1)
        }

        If (LEqual(MethodId, FWI_CMD_READ)){
          Store(0, Local0)
          If (CondRefOf(ReadSarSensorStatus))
          {
             Store(ReadSarSensorStatus(), Local0)
          }
          Store(Local0, ReturnValue)
          Store(0, StatusValue)
          Return(Local1)
        } ElseIf (LEqual(MethodId , FWI_CMD_WRITE)){
          And(ulValue,0xffffffff,Local0)
          If (CondRefOf(WriteSARControl))
          {
             WriteSARControl(Local0)
          }       
          Store(0, StatusValue)
          Store(0, ReturnValue)
          Return(Local1)
        }
      }
      Return (Local1)
    } // end of 0x40B

    // 
    // 0x40C : FWI_DYNAMICFAN_MODE LGEMOD: [SMC200319A]  00 11 10
    //                                                   00 11 22
    If (LEqual(InstanceNumber, 0x040C /*FWI_DYNAMICFAN_MODE*/))
    {
      Store(StatusCommandNotSupport, StatusValue)
      If(LEqual(XNOTE_PLATFORM_FEATURE_BATTERY, 0))
      {
        Return(Local1)
      }

      If (LEqual(MethodId, FWI_CMD_READ)){
        Store(0, Local0)
        If(CondRefOf(ReadDynamicFanMode))
        {
          Store(ReadDynamicFanMode(), Local0)
        }

// LGEMOD:BEGIN [DGK230207A] - Return WMI value 6 (Auto Mode)
#if OPTION_XNOTE_AUTO_COOLING_SUPPORT
        If(LEqual(\ODV1,3))
        {
          Store(6, Local0)
        }
#endif
// LGEMOD:END
        And(Local0, 0x0000f, Local0)
        Or(Local0, 0x10000, Local0)         // Disable DPTF Driver Reloading 
        // LGEMOD:BEGIN[SJN220117A] - Remove the no noise scenario of PM model
        If (LNot(LOr(LEqual(\XMID, XNOTE_BDID_16Z90R_PM), LEqual(\XMID, XNOTE_BDID_17Z90R_PM)))) {
          Or(Local0, 0x20000, Local0)       // No noise mode, 1XZ90Q
        }
#if OPTION_XNOTE_AUTO_COOLING_SUPPORT // LGEMOD:BEGIN [DGK230113A] - Support Auto Cooling Mode for 1xZ90RT
        Or(Local0, 0x200000, Local0)         // Support Auto Cooling Mode
#endif  // LGEMOD:END
        // LGEMOD:END
        Or(Local0, 0x40000000, Local0)      // Settings will be always restored by Platform Manager
        Store(Local0, ReturnValue)
        Store(0, StatusValue)
        Return (Local1)
      }
      ElseIf (LEqual(MethodId, FWI_CMD_WRITE)){
        And(MAR2, 0xFFFF, MAR2)
        If(CondRefOf(WriteDynamicFanMode))
        {
#if OPTION_XNOTE_AUTO_COOLING_SUPPORT // LGEMOD:BEGIN [DGK230113A] - Init Auto Mode Settings
        WriteEcField(0x00, FTMS)  // Using Normal Silent Fan Table
          If(LEqual(And(MAR2, 0x0F), 6)) // Auto
          {
            Store(3, \ODV1)
            WriteEcField(0x01, FTMS)  // Using Auto Silent Fan Table
            Store(0, \ODV2)
            Store(0, \_SB.PC00.LPCB.LGEC.TFN2.MODE)
          }
          ElseIf(LEqual(And(MAR2, 0x0F), 3)) // no noise
#else
          If(LEqual(And(MAR2, 0x0F), 3)) // no noise
#endif  // LGEMOD:END
          {
            Store(2, \ODV1)
            If (LOr(LEqual(\XMID, XNOTE_BDID_16Z90R_PM), LEqual(\XMID, XNOTE_BDID_17Z90R_PM))) {
              Store(1, \_SB.NPCF.DBAC)
              Store(0x41,\_SB.PC00.PEG0.PEGP.GTTV) // 65C
              Notify(\_SB.PC00.PEG0.PEGP, 0xD5)
            }
          }
          ElseIf(LEqual(And(MAR2, 0x0F), 2)) // performance
          {
            Store(1, \ODV1)
            If (LOr(LEqual(\XMID, XNOTE_BDID_16Z90R_PM), LEqual(\XMID, XNOTE_BDID_17Z90R_PM))) {
              Store(0, \_SB.NPCF.DBAC)
              Store(0x4E,\_SB.PC00.PEG0.PEGP.GTTV) // 78C
              Notify(\_SB.PC00.PEG0.PEGP, 0xD1)
            }
          }
          ElseIf(LEqual(And(MAR2, 0x0F), 1)) // silent
          {
            Store(0, \ODV1)
            If (LOr(LEqual(\XMID, XNOTE_BDID_16Z90R_PM), LEqual(\XMID, XNOTE_BDID_17Z90R_PM))) {
              Store(1, \_SB.NPCF.DBAC)
              Store(0x41,\_SB.PC00.PEG0.PEGP.GTTV) // 65C
              Notify(\_SB.PC00.PEG0.PEGP, 0xD4)
            }
          }
          Else{ // normal
            Store(0, \ODV1)
// LGEMOD:BDGIN [DGK230622A,DGK230208B] - Add Performance Boost Feature
#if (OPTION_BUILD_1xZ90RT) || (OPTION_BUILD_17X90R)
            Store(0, \ODV3)
#endif
// LGEMOD:END [DGK230622A,DGK230208B]
            If (LOr(LEqual(\XMID, XNOTE_BDID_16Z90R_PM), LEqual(\XMID, XNOTE_BDID_17Z90R_PM))) {
              Store(1, \_SB.NPCF.DBAC)
              Store(0x49,\_SB.PC00.PEG0.PEGP.GTTV) // 73C
              Notify(\_SB.PC00.PEG0.PEGP, 0xD1)
            }
          }
          If (LOr(LEqual(\XMID, XNOTE_BDID_16Z90R_PM), LEqual(\XMID, XNOTE_BDID_17Z90R_PM))) {
            Notify(\_SB.NPCF, 0xC0)
            Notify(\_SB.PC00.PEG0.PEGP, 0xC0)
          }
          Or(ShiftLeft(And(MAR2,0xf),4), MAR2, MAR2)
          WriteDynamicFanMode(MAR2)
        }
        Store(0, ReturnValue)
        Store(0, StatusValue)
        Return(Local1)
      }
      Return (Local1)
    }
    //
    // 0x40D : Backlit keyboard Power Saving Mode
    //
    If (LEqual(InstanceNumber, 0x40D))
    {
      Store(StatusCommandNotSupport, StatusValue)
      If (CondRefOf(IsBacklitSupported)) {
        If(LEqual(IsBacklitSupported(),0))
        {
          Return(Local1)
        }

        If (LEqual(MethodId, FWI_CMD_READ)){
          Store(0, Local0)
          If (CondRefOf(ReadBacklitKeyboardPowerSavingMode))
          {
             Store(ReadBacklitKeyboardPowerSavingMode(), Local0)
          }
          Store(Local0, ReturnValue)
          Store(0, StatusValue)
          Return(Local1)
        } ElseIf (LEqual(MethodId , FWI_CMD_WRITE)){
          And(ulValue,0xffffffff,Local0)
          If (CondRefOf(WriteBacklitKeyboardPowerSavingMode))
          {
             WriteBacklitKeyboardPowerSavingMode(Local0)
          }       
          Store(0, StatusValue)
          Store(0, ReturnValue)
          Return(Local1)
        }
      }
      Return (Local1)
    } // end of 0x040D
    //
    // 0x40E : Event Reason for Backlit keyboard Power Saving Mode
    //
    If (LEqual(InstanceNumber, 0x40E))
    {
      Store(StatusCommandNotSupport, StatusValue)
      If (CondRefOf(IsBacklitSupported)) {
        If(LEqual(IsBacklitSupported(),0))
        {
          Return(Local1)
        }

        If (LEqual(MethodId, FWI_CMD_READ)){
          Store(0, Local0)
          If (CondRefOf(ReadBacklitKeyboardPowerSavingModeEventReason))
          {
             Store(ReadBacklitKeyboardPowerSavingModeEventReason(), Local0)
          }
          Store(Local0, ReturnValue)
          Store(0, StatusValue)
          Return(Local1)
        } ElseIf (LEqual(MethodId , FWI_CMD_WRITE)){
          And(ulValue,0xffffffff,Local0)
          If (CondRefOf(WriteBacklitKeyboardPowerSavingModeEventReason))
          {
             WriteBacklitKeyboardPowerSavingModeEventReason(Local0)
          }       
          Store(0, StatusValue)
          Store(0, ReturnValue)
          Return(Local1)
        }
      }
      Return (Local1)
    } // end of 0x040D

    //
    // 0x417 : Fn ESC Support Check
    //
    If (LEqual(InstanceNumber, 0x417))
    {
      Store(StatusCommandNotSupport, StatusValue)
      If (CondRefOf(IsFxKeyOverrideSupported)) 
      {
        If(LEqual(IsFxKeyOverrideSupported(),0))
        {
          Return(Local1)
        }

        If (LEqual(MethodId, FWI_CMD_READ)){
          Store(1, Local0)
          Store(Local0, ReturnValue)
          Store(0, StatusValue)
          Return(Local1)
        } ElseIf (LEqual(MethodId , FWI_CMD_WRITE)){
          Store(0, StatusValue)
          Store(0, ReturnValue)
          Return(Local1)
        }
      }
      Return (Local1)
    } // end of 0x0417

    //
    // 0x421 : Extended Hot-Key Support
    //
    If (LEqual(InstanceNumber, 0x421))
    {
        Store(StatusCommandNotSupport, StatusValue)
        If (CondRefOf(IsExtendedHotkeySupported)) {
          If(LEqual(IsExtendedHotkeySupported(),0))
          {
            Return(Local1)
          }
          If (LEqual(MethodId, FWI_CMD_READ)){
            Store(0, ReturnValue)
            Store(0, StatusValue)
            Return(Local1)
          } ElseIf (LEqual(MethodId , FWI_CMD_WRITE)){
            Store(0, StatusValue)
            Store(0, ReturnValue)
            Return(Local1)
          }
        }
        Return (Local1)
    } // end of 0x0421

    //
    // 0x422 : HDMI, Energy Star Support
    //
    If (LEqual(InstanceNumber, 0x422))
    {
      Store(StatusCommandNotSupport, StatusValue)

      If (CondRefOf(IsELabelSupported)) {
        If(LEqual(IsELabelSupported(),0))
        {
          Return(Local1)
        }

        If (LEqual(MethodId, FWI_CMD_READ)){
          Store(0, Local0)
          If (CondRefOf(ReadEnergyStarSupported))
          {
             Store(ReadEnergyStarSupported(), Local0)
          }
          Or(ShiftLeft(Local0,1,Local0),0x01,Local0)
          Store(Local0, ReturnValue)
          Store(0, StatusValue)
          Return(Local1)
        } ElseIf (LEqual(MethodId , FWI_CMD_WRITE)){
          Store(0, StatusValue)
          Store(0, ReturnValue)
          Return(Local1)
        }
      }
      Return (Local1)
    } // end of 0x0422

    //
    // LGEMOD:BEGIN[SMK221123A] - 0x428 : Hotkey Sleep Support
    //
    If (LEqual(InstanceNumber, 0x428))
    {
      Store(StatusCommandNotSupport, StatusValue)
      If (LEqual(MethodId, FWI_CMD_READ))
      {
        Store(Zero, Local0)
        If (CondRefOf(IsHotkeySleepSupported))
        {
          Store(IsHotkeySleepSupported(), Local0)
        }
        Store(Local0, ReturnValue)
        Store(Zero, StatusValue)
        Return(Local1)
      }
      Return(Local1)
    }
    // LGEMOD:END
#if !OPTION_SUPPORT_HOTKEY_FILTER_DRIVER
    //
    // 0x0501 : Request Dummy Key (to prevent windows up event)
    //
    If (LEqual(InstanceNumber, 0x0501))
    {
      If(LEqual(\XNOTE_PLATFORM_FEATURE_KEYBOARD, 0)) {
          Return(Local1)
      }

      Store(StatusCommandNotSupport, StatusValue)
      
      If (LEqual(MethodId, FWI_CMD_READ)){
        Store(0, Local0)
        If (CondRefOf(ReadDummyKey)) 
        {
          Store(ReadDummyKey(), Local0)
        }
        ADBG(Concatenate("LG Local0=", Local0))
        Store(Local0, ReturnValue)
        Store(0, StatusValue)
        Return(Local1)
      } ElseIf (LEqual(MethodId , FWI_CMD_WRITE)){
        ADBG(Concatenate("LG ulValue=", ulValue))
        And(ulValue,0xffffffff,Local0)
        ADBG(Concatenate("LG Local0=", Local0))
        If (CondRefOf(WriteDummyKey))
        {
          WriteDummyKey(Local0)
        }       
        ADBG(Concatenate("LG Local0=", Local0))
        Store(0, StatusValue)
        Store(0, ReturnValue)
        Return(Local1)
      }
      
      Return (Local1)
    } // end of 0x0501
#endif

    //
    // 0x0502 : Internal Keyboard Lock (For Cleaning Helper)
    //
    If (LEqual(InstanceNumber, 0x0502))
    {
      If(LEqual(\XNOTE_PLATFORM_FEATURE_KEYBOARD, 0)) {
          Return(Local1)
      }

      Store(StatusCommandNotSupport, StatusValue)
      #if OPTION_SUPPORT_HOTKEY_FILTER_DRIVER
      If (LEqual(MethodId , FWI_CMD_WRITE)){
        ADBG(Concatenate("LG ulValue=", ulValue))
        And(ulValue,0xffffffff,Local0)
        ADBG(Concatenate("LG Local0=", Local0))
        If (CondRefOf(WriteInternalKeyLock))
        {
          WriteInternalKeyLock(Local0)
        }       
        ADBG(Concatenate("LG Local0=", Local0))
        Store(0, StatusValue)
        Store(0, ReturnValue)
        Return(Local1)
      }
      #else
      If (LEqual(MethodId, FWI_CMD_READ)){
        Store(0, Local0)
        If (CondRefOf(ReadInternalKeyLock)) 
        {
          Store(ReadInternalKeyLock(), Local0)
        }
        ADBG(Concatenate("LG Local0=", Local0))
        Store(Local0, ReturnValue)
        Store(0, StatusValue)
        Return(Local1)
      } ElseIf (LEqual(MethodId , FWI_CMD_WRITE)){
        ADBG(Concatenate("LG ulValue=", ulValue))
        And(ulValue,0xffffffff,Local0)
        ADBG(Concatenate("LG Local0=", Local0))
        If (CondRefOf(WriteInternalKeyLock))
        {
          WriteInternalKeyLock(Local0)
        }       
        ADBG(Concatenate("LG Local0=", Local0))
        Store(0, StatusValue)
        Store(0, ReturnValue)
        Return(Local1)
      }
      #endif
      Return (Local1)
    } // end of 0x0502
// LGEMOD:BEGIN[SMK221114A] - 0x503 : Check if the device has an OLED panel
    If (LEqual(InstanceNumber, 0x503))
    {
      Store(StatusCommandNotSupport, StatusValue)
      If (LEqual(MethodId, FWI_CMD_READ))
      {
        Store(Zero, Local0)
        If (CondRefOf(IsOledPanel))
        {
          Store (IsOledPanel(), Local0)
        }
        Store(Local0, ReturnValue)
        Store(Zero, StatusValue)
        Return (Local1)
      }
      Return (Local1)
    }
// LGEMOD:END
// LGEMOD:BEGIN[KUK230308A] - 0x504  :  Pen Battery Information
#if OPTION_BUILD_17X90R
    If (LEqual(InstanceNumber, 0x504))
    {
      Store(StatusCommandNotSupport, StatusValue)
      If (LEqual(MethodId, FWI_CMD_READ))
      {
        Store(ReadEcRamBits(0xB6,0,1), local4)          // 0xB6 Bit[0] : 0 - disconnection, 1 - connection

        If(LEqual(local4, 0)){    // PEN is detached
          Store(0, ReturnValue)
          Store(StatusInstanceNotFound, StatusValue)
          Return (Local1)
        }
        Else  // PEN is atteched
        {
        Store(ReadEcRamBits(0xB6,1,0x7F), ReturnValue)     // 0xB6 Bit[7:1] : Battery Remaping level unit %
        Store(Zero, StatusValue)
        Return (Local1)
        }
      }
      
      If (LEqual(MethodId , FWI_CMD_WRITE)){
        If(And(ulValue,0x1))
        {
          // Request New Pen Battery Value   
          \_SB.PC00.LPCB.LGEC._QA3()     
        }
        Store(0, StatusValue)
        Store(0, ReturnValue)
        Return(Local1)
      }
      Return (Local1)
    }
#endif
// LGEMOD:END  - 0x504

// LGEMOD:BEGIN[KUK230405A] - 0x505  :   Wake On Touch Enable setting.
#if OPTION_BUILD_17X90R
    If (LEqual(InstanceNumber, 0x505))
    {
      Store(StatusCommandNotSupport, StatusValue)
      If (LEqual(MethodId, FWI_CMD_READ))
      {
        ADBG("Read WOT status")
        Store(XnoteSmiHandler (0x51, 0 , 0 ,0), ReturnValue)
        ADBG(Concatenate("WOT Enalbe status  =", ReturnValue))
        Store(Zero, StatusValue)
        Return (Local1)
      }

      If (LEqual(MethodId , FWI_CMD_WRITE)){
        If(And(ulValue,0x1))
        {
          // Enable Wake On Touch
          Store(0, Local0)                  // Wake On Touch is a Low Active
          ADBG(Concatenate("Set WOT Enalbe =", Local0))
          WriteGpio(WoTControlGPIO, Local0)
          XnoteSmiHandler (0x50, 1 , 0 ,0)  // Save WoT status to PCD
        }
        Else
        {
          // Disable Wake On Touch
          Store(1, Local0)
          ADBG(Concatenate("Set WOT Enalbe =", Local0))
          WriteGpio(WoTControlGPIO, Local0)
          XnoteSmiHandler (0x50, 0 , 0 ,0)  // Save WoT status to PCD
        }
        Store(0, StatusValue)
        Store(0, ReturnValue)
        Return(Local1)
      }
      Return (Local1)
    }
#endif
// LGEMOD:END  - 0x505

    Return (Local1)
  } // If(LGreaterEqual(InstanceNumber, 0x100))

  If( LAnd(LGreaterEqual( InstanceNumber, 0x00 ), LLessEqual( InstanceNumber, 0x2f ))) {

  
    //
    //  0x0000:FWI_INTERFACE_VERSION (Read Only)
    //             0x300 for Interface versino 3.0
    //
    If(LEqual(InstanceNumber , 0x0000 /* FWI_INTERFACE_VERSION */)){
        If (LEqual(MethodId , FWI_CMD_READ )){
          Return (0x00000303)
        }
        Return (StatusCommandNotSupport)         // command not support
    }

    //
    // 0x0001:FWI_WMI_EVENT_EN (Read Only)
    //
    //
    If (LEqual(InstanceNumber , 0x0001 /*FWI_WMI_EVENT_EN*/ )){
      If (LEqual(MethodId , FWI_CMD_READ )){
        Return (One)
      }
      Return (StatusCommandNotSupport)         // command not support
    }
    
    //
    // 0x0002:FWI_ECON_STATUS (Read Only)
    //
    If (LEqual(InstanceNumber , 0x0002 /*FWI_ECON_STATUS*/)){
      If (LEqual(MethodId , FWI_CMD_READ ))
      {
        Return (1)
      }
      Return (StatusCommandNotSupport)         // command not support
    }

    //
    // 0x0003:FWI_EC_VERSION (Read Only)
    //
    If (LEqual(InstanceNumber , 0x0003 /*FWI_EC_VERSION*/ )){
      If (LEqual(MethodId , FWI_CMD_READ)){
        Store(0, Local0)
        If(CondRefOf(ReadEcRevision))
        {
          Store( ReadEcRevision(), Local0)
        }
        Return (Local0)
      }
      Return (StatusCommandNotSupport)         // command not support
    }

    //
    // 0x0004:FWI_MODEL_ID (Read Only)
    //
    If (LEqual(InstanceNumber , 0x0004 /*FWI_MODEL_ID*/)){
      If (LEqual(MethodId , FWI_CMD_READ)){
        Store(0, Local0)
        If(CondRefOf(ReadModelId))
        {
          Store( ReadModelId(), Local0)
        }
        Return (Local0)
      }
      Return (StatusCommandNotSupport)         // command not support
    }

    //
    // 0x0005:FWI_CRITICAL_S4_BY_APP (will be removed)
    //
    If (LEqual(InstanceNumber , 0x0005 /*FWI_CRITICAL_S4_BY_APP*/)){
      If (LEqual(MethodId /*ulMethodId*/, 1 /*FWI_CMD_READ*/)){
        Return(APCT)
      } ElseIf (LEqual(MethodId , FWI_CMD_WRITE)){
        Store(ulValue , APCT)
        Return( 0 /*FWI_SUCCESS*/ )
      }
      Return (StatusCommandNotSupport)         // command not support
    }

    //
    // 0x0006:FWI_HIBERNATION_FLAG
    //
    If (LEqual(InstanceNumber , 0x0006 /*FWI_HIBERNATION_FLAG*/)){
      If (LEqual(MethodId , FWI_CMD_READ)){
        Store(HINH, Local0)
        Return( Local0 )
      } ElseIf (LEqual(MethodId , FWI_CMD_WRITE)){
        Store(ulValue , Local0)
        Store(Local0,HINH)
        Return(  0 /*FWI_SUCCESS*/  )
      }
      Return (StatusCommandNotSupport)         // command not support
    }

    //
    // 0x0007:FWI_EMULATE_MISC (Obsolite)
    //

    //
    // 0x0008:FWI_ATA_ATAPI
    //
    If (LEqual(InstanceNumber , 0x0008 /*FWI_ATA_ATAPI*/)){
      Return (StatusCommandNotSupport)         // command not support
    }

    //
    // 0x0009:FWI_FAKE_SSID
    //
    If (LEqual(InstanceNumber , 0x0009 /*FWI_FAKE_SSID*/))
    {
      Return (StatusCommandNotSupport)         // command not support
    }

    //
    // 0x000A:FWI_LCD_RESOLUTION
    //
    If (LEqual(InstanceNumber, 0x000A))
    {
      Return (StatusCommandNotSupport)         // command not support
    }
    
    //
    // 0x000B ~ 0x000D : Not Assigned
    //

    //
    // 0x000E:FWI_FEATURE_SUPPORT1
    //
    If (LEqual(InstanceNumber , 0x000E /*FWI_FEATURE_SUPPORT1*/))
    {
      If (LEqual(MethodId , FWI_CMD_READ)) {
        Store(0x04004100, Local0)
        If(CondRefOf(ReadFeatureSupport1))
        {
          Store(ReadFeatureSupport1(), Local0)
        }
        Return (Local0)
      }
      Return (StatusCommandNotSupport)         // command not support
    }

    //
    // 0x000F:FWI_FEATURE_SUPPORT2
    //
    If (LEqual(InstanceNumber, 0x000F /*FWI_FEATURE_SUPPORT2*/))
    {
      If (LEqual(MethodId, 1 /*FWI_CMD_READ*/)){
        Store(0x00000009, Local0)
        If(CondRefOf(ReadFeatureSupport2))
        {
          Store(ReadFeatureSupport2(), Local0)
        }
        Return(Local0)
      }
      Return (StatusCommandNotSupport)         // command not support
    }

    //
    // 0x0010 ~ 0x002F : Not Assigned
    //
     Return(0x80000001)        // Instance not support
  } // 0x00~0x2f


  If( LAnd(LGreaterEqual( InstanceNumber, 0x30 ), LLessEqual( InstanceNumber /*ulInstance*/, 0x5f )))
  {
    //
    // 0x003A:FWI_APP_REQUEST1
    //
    If (LEqual(InstanceNumber, 0x003A /*FWI_APP_REQUEST1*/ ))
    {
      If (LEqual(MethodId, FWI_CMD_WRITE)){
        If(CondRefOf(RequestedByApplication1))
        {
          RequestedByApplication1(ulValue)
        }
        Return(  0 /*FWI_SUCCESS*/  )
      }
      Return (StatusCommandNotSupport)         // command not support
    }

    // OSD Touch Pad Control implementation
    //
    // 0x0030:FWI_TOUCH_KEY_PAD
    //
    If (LEqual(InstanceNumber , 0x0030 /*FWI_TOUCH_KEY_PAD*/)){
      If (CondRefOf(TouchPadControlMethod)) {
        Return(TouchPadControlMethod(MethodId , ulValue))
      }
      else
      {
        Return(0)
      }
    }

    //
    // 0x0031:FWI_POWER_CTRL
    //
    If (LEqual(InstanceNumber, 0x0031 /*FWI_POWER_CTRL*/)){
      Return(WmiWirelessPowerControl(MethodId , ulValue)) // WirelessPowerControl
    }

    //
    // 0x0033:FWI_DYNAMICFAN_MODE LGEMOD: [YSB160608C]
    //
    If (LEqual(InstanceNumber, 0x0033 /*FWI_DYNAMICFAN_MODE*/))
    {
        If (LEqual(MethodId, FWI_CMD_READ)){

          Store(0, Local0)
          If(CondRefOf(ReadDynamicFanMode))
          {
            Store(ReadDynamicFanMode(), Local0)
          }
          Return (Local0)
        }
        ElseIf (LEqual(MethodId, FWI_CMD_WRITE)){
          If(CondRefOf(WriteDynamicFanMode))
          {
            WriteDynamicFanMode(ulValue)
          }
          Return(  0 /*FWI_SUCCESS*/  )
        }

        Return (StatusCommandNotSupport)         // command not support
    }

    //
    // 0x0034:FWI_DEVICE_CTRL_OWNERSHIP
    //
    If (LEqual(InstanceNumber, 0x0034 /*FWI_DEVICE_CTRL_OWNERSHIP */))
    {
        If (LEqual(MethodId , FWI_CMD_READ)){
          Return (OWNE)
        }
        ElseIf (LEqual(MethodId , FWI_CMD_WRITE)){
          Store(ulValue, OWNE)
          Return(  0 /*FWI_SUCCESS*/  )
        }
        Return (StatusCommandNotSupport)         // command not support
    }

    // using iRST via RstManagerSvc instead of Fn-F4
    //
    // 0x0035:FWI_IRST
    //
    If (LEqual(InstanceNumber, 0x0035 /*FWI_DEVICE_CTRL_OWNERSHIP */))
    {
        Return (StatusCommandNotSupport)         // command not support
    }

    //
    // 0x0039:FWI_APP_REQUEST0
    //
    If (LEqual(InstanceNumber, 0x0039 /*FWI_APP_REQUEST0*/))
    {
      If (LEqual(MethodId, FWI_CMD_READ)){
        Return (ARQ0)
      }
      ElseIf (LEqual(MethodId , FWI_CMD_WRITE)){
        Store(ulValue, ARQ0)
        Return(  0 /*FWI_SUCCESS*/  )
      }
      Return (StatusCommandNotSupport)         // command not support
    }

    //
    // 0x003B:FWI_APP_REQUEST1_STATUS
    //
    If (LEqual(InstanceNumber, 0x003B /*FWI_APP_REQUEST1_STATUS*/))
    {
      If (LEqual(MethodId, FWI_CMD_READ)){
        Return (StatusCommandNotSupport)         // command not support
      }
      Return (StatusCommandNotSupport)         // command not support
    }

    //
    // 0x003C:FWI_DEVICE_PRESENCE0
    //
    If (LEqual(InstanceNumber, 0x003C /*FWI_DEVICE_PRESENCE0*/))
    {
      If (LEqual(MethodId, FWI_CMD_READ)){
        Return (CheckDevicePresence0())
      }
      Return (StatusCommandNotSupport)         // command not support
    }

    //
    // 0x003D:FWI_DEVICE_PRESENCE1
    //
    If (LEqual(InstanceNumber, 0x003D /*FWI_DEVICE_PRESENCE1*/))
    {
      If (LEqual(MethodId, FWI_CMD_READ)){
        Return (CheckDevicePresence1())
      }
      Return (StatusCommandNotSupport)         // command not support
    }

    //
    // 0x003E:FWI_VOLUME_CONTROL
    //
    If (LEqual(InstanceNumber, 0x003E /*FWI_VOLUME_CONTROL*/))
    {
      If(CondRefOf(FwiVolumeControl))
      {
        return(FwiVolumeControl(MethodId, ulValue))
      }
      Else
      {
        Return (StatusCommandNotSupport)
      }
    }
    Return(StatusCommandNotSupport1)        // Instance not support
  } // 0x30~0x5f

  If( LAnd(LGreaterEqual( InstanceNumber /*ulInstance*/, 0x60 ), LLessEqual( InstanceNumber /*ulInstance*/, 0x8f )))
  {
    //
    // 0x0060:FWI_BRIGHTNESS_CTRL
    //
    If (LEqual(InstanceNumber /*ulInstance*/, 0x0060 /*FWI_BRIGHTNESS_CTRL*/))
    {
      Return(WmiBrightnessControl(MethodId /*ulMethodId*/, ulValue /*ulValue*/))
    }

    //
    // 0x0061:FWI_BATTERY_STOP_PERCENT
    //
    If (LEqual(InstanceNumber /*ulInstance*/, 0x0061 /*FWI_BATTERY_STOP_PERCENT*/))
    {
      If(CondRefOf(FwiBatteryStopPercent))
      {
        return(FwiBatteryStopPercent(MethodId, ulValue))
      }
      Else
      {
        Return (StatusCommandNotSupport)
      }
    }

    //
    // 0x0062:FWI_BRIGHTNESS_STEP_CTRL
    //
    If (LEqual(InstanceNumber /*ulInstance*/, 0x0062 /*FWI_BRIGHTNESS_STEP_CTRL*/)){
      Return(BCT1(MethodId /*ulMethodId*/, ulValue /*ulValue*/))
    }

    //
    // 0x0063:FWI_WMI_EVENT_EN (Read Only)
    //
    //
    If (LEqual(InstanceNumber /*ulInstance*/, 0x0001 /*FWI_WMI_EVENT_EN*/ )){
      If (LEqual(MethodId, FWI_CMD_READ )){
        Return (One)
      }
      Return (StatusCommandNotSupport)
    }

          If(LEqual(XNOTE_PLATFORM_FEATURE_BATTERY, 1))
          {
                //
                // 0x0067:FWI_BATTERY_ALARM1
                //
                If (LEqual(InstanceNumber /*ulInstance*/, 0x0067 /*FWI_BATTERY_ALARM1*/))
                {
                  If(CondRefOf(FwiBatteryAlarm1))
                  {
                    return(FwiBatteryAlarm1(MethodId, ulValue))
                  }
                  Else
                  {
                    Return (StatusCommandNotSupport)
                  }
                }

                //
                // 0x0068:FWI_BATTERY_ALARM2
                //
                If (LEqual(InstanceNumber /*ulInstance*/, 0x0068 /*FWI_BATTERY_ALARM2*/))
                {
                  If(CondRefOf(FwiBatteryAlarm2))
                  {
                    return(FwiBatteryAlarm2(MethodId, ulValue))
                  }
                  Else
                  {
                    Return (StatusCommandNotSupport)
                  }
                }
                //
                // 0x0069:FWI_BATTERY_PWR_ON_PREVENT
                //
                If (LEqual(InstanceNumber /*ulInstance*/, 0x0069 /*FWI_BATTERY_PWR_ON_PREVENT*/))
                {
                  If(CondRefOf(FwiBatteryPowerOnPrevent))
                  {
                    return(FwiBatteryPowerOnPrevent(MethodId, ulValue))
                  }
                  Else
                  {
                    Return (StatusCommandNotSupport)
                  }
                }
          }


          //
          // 0x0072:FWI_LG_SPEED_STEP_CTRL
          //
          //
          // 0x0073:FWI_BM_MISC
          //
          If (LEqual(InstanceNumber, 0x0073))
          {
            If(CondRefOf(FwiBmMisc))
            {
              return(FwiBmMisc(MethodId, ulValue))
            }
            Else
            {
              Return (StatusCommandNotSupport)
            }                  
          }
          //
          // 0x0079:FWI_EC_TEST_INTERFACE
          //
          If (LEqual(InstanceNumber, 0x0079))
          {
            If(CondRefOf(FwiEcTestInterface))
            {
              return(FwiEcTestInterface(MethodId, ulValue))
            }
            Else
            {
              Return (StatusCommandNotSupport)
            }
          }
          //
          // 0x0080:
          //
          // Monitor On/Off App Interface
          If (LEqual(InstanceNumber, 0x80))
          {
            If(CondRefOf(FwiMonitorOfOffInterface))
            {
              return(FwiMonitorOfOffInterface(MethodId, ulValue))
            }
            Else
            {
              Return (StatusCommandNotSupport)
            }
          }
           //
           // 0x0081: FWI_APP_WORKING
           //
           If (LEqual(InstanceNumber, 0x81)){
            If(CondRefOf(FwiAppWorking))
            {
              return(FwiAppWorking(MethodId, ulValue))
            }
            Else
            {
              Return (StatusCommandNotSupport)
            }
           }
          //
          // 0x0082: FWI_EVENT_FIRE
          //
          If (LEqual(InstanceNumber, 0x82))
          {
            If(CondRefOf(FwiEventFire))
            {
              return(FwiEventFire(MethodId, ulValue))
            }
            Else
            {
              Return (StatusCommandNotSupport)
            }
          }
          Return(0x80000001)        // Instance not support
        } // 0x60~0x8f


        If( LAnd(LGreaterEqual( InstanceNumber /*ulInstance*/, 0x90 ), LLessEqual( InstanceNumber /*ulInstance*/, 0xbf )))
        {
          //
          // 0x0090:FWI_MEMORY_TEMP
          //
          If (LEqual(InstanceNumber /*ulInstance*/, 0x0090 /*FWI_MEMORY_TEMP*/)){

            If(CondRefOf(GetMemoryTemperature))
            {
              return(GetMemoryTemperature(MethodId, ulValue))
            }
            Else
            {
              Return (StatusCommandNotSupport)
            }
          }

          //
          // 0x0091:FWI_CPU_TEMP
          //
          If (LEqual(InstanceNumber /*ulInstance*/, 0x0091 /*FWI_CPU_TEMP*/)){
            If(CondRefOf(GetCpuTemperature))
            {
              return(GetCpuTemperature())
            }
            Else
            {
              Return (StatusCommandNotSupport)
            }
          }

          //
          // 0x0092:FWI_LOCAL_TEMP
          //
          If (LEqual(InstanceNumber /*ulInstance*/, 0x0092 /*FWI_LOCAL_TEMP*/)){                //@YSB061230B
            If(CondRefOf(GetLocalTemperature))
            {
              return(GetLocalTemperature())
            }
            Else
            {
              Return (StatusCommandNotSupport)
            }
          }

          // 0x00B3: EC bit Control Method (RW) for Pop Noise Reduction
          //
          // Bit[0]   : Directly Reflect Mute EC Ram(RW)
          // Bit[30: 1] - Reserved
          // Bit[31] - Must be 0 when the instance is available
          If (LEqual(InstanceNumber /*ulInstance*/, 0x00B3 /*FWI_HIBERNATION_FLAG*/)){
            If(CondRefOf(FwiPopNoiseReduction))
            {
              return(FwiPopNoiseReduction(MethodId, ulValue))
            }
            Else
            {
              Return (StatusCommandNotSupport)
            }
          }

          //
          // 0x00BE: Platform Type
          //
          // 1 : Note Book
          // 2 : Tab Book
          // 3 : 2 in 1
          // 4 : All in One
          // 5 : T-Station
          // 6 : Signage
          //
          // 31bit : Must be 0 when the instance is available
          //
          If (LEqual(InstanceNumber /*ulInstance*/, 0x00BE )){
            If (LEqual(MethodId /*ulMethodId*/, 1 /*FWI_CMD_READ*/)){
              Store(1, Local0)        // Default value is notebook.
              If(CondRefOf(GetPlatformType))
              {
                Store(GetPlatformType(), Local0)
              }
              Return( Local0 )
            }
            Return (StatusCommandNotSupport)
          }
    
          //
          // 0x00BF: Reader Mode Method
          //
          // Bit [0]   : Reader Mode Indicator. (WO)
          //             1 : for Reader Mode is on.
          //             0 : for Reader Mode is off.
          // Bit[3:1]  : Reader Mode Type (RO)
          //             1 : LCD support reader mode by itself.
          //             0 : Software emulated reader mode
          // Bit [4]   : Backlight Brightness Control over Serial Port (RO) - AIO
          // Bit[30:5] : Reserved
          // Bit[31]   : must be 0 if Reader Mode is supported
          If (LEqual(InstanceNumber, 0x00BF)){
            If (LEqual(MethodId, 1)){
              Store(0, Local0)
              If(CondRefOf(ReadReaderMode))
              {
                Store(ReadReaderMode(),Local0)
              }
              Return(Local0)
            }
            ElseIf (LEqual(MethodId, 2)){
              If(CondRefOf(WriteReaderMode))
              {
                WriteReaderMode(ulValue)
              }
              Return(0)
            }
            Return (StatusCommandNotSupport)
          }
          Return(0x80000001)
        } // 0x90~0xbf


        If( LAnd(LGreaterEqual( InstanceNumber, 0xc0 ), LLessEqual( InstanceNumber, 0xff )))
        {
          //
          // 0x00EF:FWI_ECO_MODE_STATUS
          //
          If (LEqual(InstanceNumber, 0x00EF))
          {
            If(CondRefOf(FwiEcoModeHandler))
            {
              Return(FwiEcoModeHandler(MethodId, ulValue))
            }
            Else
            {
              Return (StatusCommandNotSupport)
            }
          }
          Return(0x80000001)
        } // 0xc0~0xff
  Return (StatusInstanceNotFound)
}
