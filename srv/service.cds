using { migration as db } from '../db/schema';

service DatamigrationService {

  entity Waves as projection on db.Waves {
    ID,
    name,
    startDate,
    endDate,
    actualStartDate,
    actualEndDate,
      status,
    case
      when status = 'COMPLETED'     then 3
      when status = 'IN_PROGRESS'  then 2
      when status = 'ON_HOLD'       then 1
      when status = 'YET_TO_START' then 5
      else 0
    end              as StatusCriticality : Integer,
    rag,

    /* RAG → Criticality */
    case
      when rag = 'G' then 3
      when rag = 'A' then 2
      when rag = 'R' then 1
      else 0
    end as ragCriticality : Integer,
    completionPercent,
    /* Percent → Criticality */
    case
      when completionPercent >= 70 then 3 // Green
      when completionPercent >= 40 then 2   // Amber
      else 1                          // Red
    end as progressCriticality : Integer,

    rollouts : redirected to Rollouts
  };

  entity Rollouts as projection on db.Rollouts {
    ID,
    name,
   //  @UI.Hidden
 //wave_id, // added by sp
    status,
    case
      when status = 'COMPLETED'     then 3
      when status = 'IN_PROGRESS'  then 2
      when status = 'ON_HOLD'       then 1
      when status = 'YET_TO_START' then 5
      else 0
    end              as StatusCriticality : Integer,
    startDate,
    actualStartDate,
    reason,

    lastModifiedAt,
    waves : redirected to Waves,
    mocks : redirected to Mocks

  };

  @readonly
  entity Mocks             as projection on db.Mocks{
    ID,
    name,
   // rollout_id, // added by
    @Common.Text: StatusText
    @Common.TextArrangement: #TextOnly
    status as Status,

    // Direct Text Mapping
    case
        when status = 'COMPLETED'    then 'Completed'
        when status = 'IN_PROGRESS'  then 'In Progress'
        when status = 'ON_HOLD'      then 'On Hold'
        when status = 'YET_TO_START' then 'Yet to Start'
        else status
    end as StatusText : String,

    // Criticality: 1=Red, 2=Yellow, 3=Green, 5=Blue
    case
        when status = 'COMPLETED'    then 3
        when status = 'IN_PROGRESS'  then 2
        when status = 'ON_HOLD'      then 1
        when status = 'YET_TO_START' then 5
        else 0
    end as StatusCriticality : Integer,

    startDate,
    endDate,
    completionPercent,
    rollouts : redirected to Rollouts,
    mockstreams : redirected to Mockstream
  };


  @readonly
  entity Streams as projection on db.Streams {
    key id,
    name,
    mockStreams : redirected to Mockstream
  };


    @readonly
  entity Mockstream as projection on db.MockStream {
    key mockStreamId,
    startDate,
    endDate,
    status,
    case
      when status = 'COMPLETED'    then 3
      when status = 'YET_TO_START' then 0
      when status = 'IN_PROGRESS'  then 2
      when status = 'ON_HOLD'       then 1
      else 0
    end             as StatusCriticality : Integer,
    lastModifiedAt  as time,
    lastModifiedBy  as owner,
    notes           as remarks,
    mock : redirected to Mocks,
    stream :redirected to Streams,
    
  };

   @readonly
    entity Objects  as projection on db.Objects{
      key id,
      name,
      stream : redirected to Streams,
      mockStreams : redirected to MockStreamObjects
    };

    @readonly 
    entity MockStreamObjects as projection on db.MockStreamObjects{
  
        mockStreams : redirected to Mockstream,
        object : redirected to Objects,

    };

}